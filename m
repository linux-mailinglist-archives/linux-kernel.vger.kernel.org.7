Return-Path: <linux-kernel+bounces-843565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96322BBFBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7C2F4E8E84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8571E51EB;
	Mon,  6 Oct 2025 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K77FT//E"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D720C001
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791770; cv=none; b=MDGnnGnfmpIdZjvPEaOxM6Vc82DQDqmvmxgrXeTeyYMn3Lo3MiJ6ADzcG43FviazIaqKVuFEkvtTQp7MZ7t4DIGb4SbbY0/tD0rsde3xH7wPgkaRVpADqpUQmX/crGPf4XAtCOGk1QpYDI0kw6iVJEwBystMi9SrsEfA7ZwsvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791770; c=relaxed/simple;
	bh=nbmXBpDxVnvRf1f0q05Wx4GSobn077qBwuI1FqufAH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKWqKhM7Tys3bbtQz89p0TMPuTa7qqi6g0rkmWCBT6HeulUm5xMbEqSoGdQMsSM7rPC2ZcPpRvRXQgO2EvAJ+vGOqyMBhKLavD0f/goZH8vhpbrjyipK4dM6WdXsP0Vp9TrtZk12ZuxMy0/6Rfe41RzNuJQ9rlOM+AJykiC7M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K77FT//E; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso8582378a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791766; x=1760396566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mH/MC1pzhxx8vZYlOptz8tbIP9fL5hh6dB1cSmfVr7E=;
        b=K77FT//EJlohpPbAxk1BRQ3HtysBrjJbfBho5kzLeaXuIYT5kizoXgwqsQ2+yIGabh
         FJ+ROnVKcwuLcKrlM+Ho3dEwcNNTcGAzT+Qv+20SutNtPPP6vQhowG3V6RpBsYEoSUmS
         r4tQpFnnLJ3GNhD/ewJ3YqF3hg68UNxqyRS60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791766; x=1760396566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH/MC1pzhxx8vZYlOptz8tbIP9fL5hh6dB1cSmfVr7E=;
        b=tet//kyloTB2p3qnYgetgbsqMYJ3F39EFjq9/PcJIBS/hYPPNFu03urjhRuMkn8SgZ
         ZUselS67rr7irNbewCPWSS+hZhuQUXRYVIaOQWGV4yGPMeBWge0j5oELKyrkC8N/uf3B
         rKX8YgPenDJUeSRdfFsamSKCxSpiqLDLnUlDDnLhJFGjfMl+hgsVKpyUrsr3b6jznLZo
         b1NrpzJZWgKGb3L2hWQ39PO9MOI8rfa/8I51ts4vn39fE0iCONjMmSg79qpj69kNJCfx
         CFHKDj/XJ25BUWTUiijiVowroujr7/Sv0naxmHHACzwEdgGarPcD/eybyXTl0/M26eXm
         9QYA==
X-Forwarded-Encrypted: i=1; AJvYcCX43ib2vLgkl5sjZhkDJ5iEUZiRXeDK54mygTz/mabNdsSulKaqQ5+XqSJHuG1qer/ZKZMi5PYGGFOTq4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKR+dzcevtbHmLRyApXq9+ESW9vwIBFaERsiGYgkRsJ3JDM/Zh
	uvyNWhYxu0Bw0CIa0KpnEGK8DgcRkQi2DThx+R1urYqmQvjVT6b0qWT2jSlKaBzcREHYWUAMU0i
	06OO4V3TRrvpGAGPZ4lDkyVoYulNBPvGL8YmgSwaP
X-Gm-Gg: ASbGncuQfI7LyN3lA5HGZ0dv278lKi5MJNdWSYO6wtoh1pmPoSpzAAAReKQgUTxpxhU
	844SgxGSnLnxoHJocLmZZUhOGKBF/qOJFIGgYfG0v0xsnHgky8QzaGorUddL8wPDBMpC5Ejej2i
	gxed6TPjhbN7kc3rM/92lEvlS5hmAp+Z8VgI6gwAZmvAXMCtl4i0c3HkgxJbapP99Td32Nyj0pw
	iOKvyDWwwJ6+eB8BpwhspOmVRGMkdIJ
X-Google-Smtp-Source: AGHT+IG9b5sf6TP4aq93x598FsC5zWPM2H6szWgkH/POv77Qg71Luo9rBf4URFhYAsGgiDICi3PLSs2LdTOktZnVHwE=
X-Received: by 2002:a05:6402:51c6:b0:637:e3a2:7678 with SMTP id
 4fb4d7f45d1cf-639348db491mr15446272a12.9.1759791766314; Mon, 06 Oct 2025
 16:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922224835.1918759-1-sjg@chromium.org> <20250922224835.1918759-4-sjg@chromium.org>
 <2d737cec-8cfa-4a72-9028-4601c3e51185@pengutronix.de>
In-Reply-To: <2d737cec-8cfa-4a72-9028-4601c3e51185@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 17:02:34 -0600
X-Gm-Features: AS18NWAJHrlgSbZsucRXEt_5TZCGk2ZtPNiXa9XkHUg202E3D0tlCLJ12e5C43Y
Message-ID: <CAFLszTgDs3Ofh3sc89PArS_-AY4MbDonmper3XDAHJmLLZ6YKw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] scripts/make_fit: Provide a way to add built modules
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Schier <nicolas@fjasle.eu>, 
	Tom Rini <trini@konsulko.com>, =?UTF-8?B?SiAuIE5ldXNjaMOkZmVy?= <j.ne@posteo.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Ahmad,

On Thu, 25 Sept 2025 at 01:43, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> Thanks for looking into this!
>
> On 9/23/25 12:48 AM, Simon Glass wrote:
> > +def build_ramdisk(args, tmpdir):
> > +    """Build a cpio ramdisk containing kernel modules
> > +
> > +    Similar to mkinitramfs, this creates a compressed cpio-archive containing
> > +    the kernel modules for the current kernel version.
> > +
> > +    Args:
> > +        args (Namespace): Program arguments
> > +        tmpdir (str): Temporary directory to use for modules installation
> > +
> > +    Returns:
> > +        tuple:
> > +            bytes: Compressed cpio data containing modules
> > +            int: total uncompressed size
> > +    """
> > +    suppress = None if args.verbose else subprocess.DEVNULL
> > +    # Use provided tmpdir or custom install path
> > +    if args.path:
> > +        mod_path = args.path
> > +    else:
> > +        mod_path = os.path.join(tmpdir, 'modules_install')
> > +        os.makedirs(mod_path, exist_ok=True)
> > +
> > +    if args.verbose:
> > +        print(f'Installing modules to {mod_path}')
> > +
> > +    cmd = ['make', '-s', '-j']
>
> Executing `make image.fit FIT_MODULES=1` in a fresh build will result in
> a python stack trace, because image.fit only has dependencies for the
> kernel image and the device trees, but none for the modules.
>
> Even with that added, I don't think it's a good idea to have make call a
> script only for it to call make again.

Yes I don't like that either.

>
> Instead, there should probably be a modules.cpio.gz make target or
> similar in its own right and image.fit should depend on it if
> FIT_MODULES is set.

That seems better. I'll give it a try.

>
> Thanks,
> Ahmad
>
> > +
> > +    # It seems that the only way to prevent a 'jobserver unavailable' warning
> > +    # is to remove it from the makeflags
> > +    env = os.environ.copy()
> > +    makeflags = env.get('MAKEFLAGS', '')
> > +    env['MAKEFLAGS'] = ' '.join(f for f in makeflags.split()
> > +                                if not f.startswith('--jobserver-auth'))
> > +
> > +    if args.build_dir:
> > +        cmd.append(f'O={args.build_dir}')
> > +    cmd.extend(['INSTALL_MOD_PATH=' + mod_path, 'modules_install'])
> > +    subprocess.check_call(cmd, cwd=os.getcwd(), stdout=suppress, env=env)
> > +
> > +    # Find the modules directory that was created (e.g. due to dirty tree)
> > +    base_dir = os.path.join(mod_path, 'lib', 'modules')
> > +    if not os.path.exists(base_dir):
> > +        raise ValueError(f'Modules base directory {base_dir} not found')
> > +    dirs = [d for d in os.listdir(base_dir)
> > +            if os.path.isdir(os.path.join(base_dir, d))]
> > +    if not dirs:
> > +        raise ValueError(f'No module directories found in {base_dir}')
> > +    if len(dirs) > 1:
> > +        raise ValueError(f'Must have only one module directory in {base_dir}')
> > +
> > +    # Create initramfs-style directory structure (usr/lib/modules instead of
> > +    # lib/modules) and move modules into it
> > +    outdir = os.path.join(tmpdir, 'initramfs')
> > +    new_dir = os.path.join(outdir, 'usr', 'lib', 'modules')
> > +    os.makedirs(new_dir, exist_ok=True)
> > +    shutil.move(os.path.join(base_dir, dirs[0]), os.path.join(new_dir, dirs[0]))
> > +
> > +    if args.verbose:
> > +        print(f'Creating cpio archive from {outdir}')
> > +
> > +    with tempfile.NamedTemporaryFile() as cpio_file:
> > +        # Change to initramfs directory and create cpio archive
> > +        with subprocess.Popen(['find', '.', '-print0'], cwd=outdir,
> > +                              stdout=subprocess.PIPE) as find:
> > +            with subprocess.Popen(['cpio', '-o', '-0', '-H', 'newc'],
> > +                                  stdin=find.stdout, stdout=cpio_file,
> > +                                  stderr=suppress, cwd=outdir) as cpio:
> > +                find.stdout.close()
> > +                cpio.wait()
> > +                find.wait()
> > +
> > +                if cpio.returncode != 0:
> > +                    raise RuntimeError('Failed to create cpio archive')
> > +
> > +        cpio_file.seek(0)  # Reset to beginning for reading
> > +        return compress_data(cpio_file, args.compress), cpio_file.tell()
> > +
> > +
> >  def process_dtb(fname, args):
> >      """Process an input DTB, decomposing it if requested and is possible
> >
> > @@ -318,11 +414,12 @@ def _process_dtbs(args, fsw, entries, fdts):
> >      return seq, size
> >
> >
> > -def build_fit(args):
> > +def build_fit(args, tmpdir):
> >      """Build the FIT from the provided files and arguments
> >
> >      Args:
> >          args (Namespace): Program arguments
> > +        tmpdir (str): Temporary directory for any temporary files
> >
> >      Returns:
> >          tuple:
> > @@ -344,20 +441,29 @@ def build_fit(args):
> >
> >      # Handle the ramdisk if provided. Compression is not supported as it is
> >      # already compressed.
> > +    ramdisk_data = None
> >      if args.ramdisk:
> >          with open(args.ramdisk, 'rb') as inf:
> > -            data = inf.read()
> > -        size += len(data)
> > -        write_ramdisk(fsw, data, args)
> > +            ramdisk_data = inf.read()
> > +        size += len(ramdisk_data)
> > +    elif args.modules_ramdisk:
> > +        if args.verbose:
> > +            print('Building modules ramdisk...')
> > +        ramdisk_data, uncomp_size = build_ramdisk(args, tmpdir)
> > +        size += uncomp_size
> > +
> > +    if ramdisk_data:
> > +        write_ramdisk(fsw, ramdisk_data, args)
> >
> >      count, fdt_size = _process_dtbs(args, fsw, entries, fdts)
> >      size += fdt_size
> >
> > -    finish_fit(fsw, entries, bool(args.ramdisk))
> > +    finish_fit(fsw, entries, has_ramdisk=bool(ramdisk_data))
> >
> > -    # Include the kernel itself in the returned file count
> >      fdt = fsw.as_fdt()
> >      fdt.pack()
> > +
> > +    # Count FDT files, kernel, plus ramdisk if present
> >      return fdt.as_bytearray(), count + 1 + bool(args.ramdisk), size
> >
> >
> > @@ -365,7 +471,12 @@ def run_make_fit():
> >      """Run the tool's main logic"""
> >      args = parse_args()
> >
> > -    out_data, count, size = build_fit(args)
> > +    tmpdir = tempfile.mkdtemp(prefix='make_fit_')
> > +    try:
> > +        out_data, count, size = build_fit(args, tmpdir)
> > +    finally:
> > +        shutil.rmtree(tmpdir)
> > +
> >      with open(args.output, 'wb') as outf:
> >          outf.write(out_data)
> >
>
> --
> Pengutronix e.K.                  |                             |
> Steuerwalder Str. 21              | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |
>

Regards,
Simon

