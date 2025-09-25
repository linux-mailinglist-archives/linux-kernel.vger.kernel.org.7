Return-Path: <linux-kernel+bounces-831921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD0B9DE31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FB24C12FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070732E8E11;
	Thu, 25 Sep 2025 07:43:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77571A2541
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786229; cv=none; b=JTDBmfp7v7PZ5bfYQBtOli8YC+COIh+QcJY3ladO+I+Lhjz2YVJyC4uVHaQUIGc7UTs3PcaTXwKD6nlr4uMSSCttbHJmNoeElOvf8PyEeLcte3NIUrs/APNd/66L8uLGFYJh9302bayi/6rv+k3TpqDPAfhH/987aPPxgiGkY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786229; c=relaxed/simple;
	bh=Ri6XzxVzNo4/HcL9e5IkltybgQmNeEbmS2wvvc6rsj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZySE4kFHuCbgx6GX+yjFlipAUtGm5Tyxsnv8GEQ8jJsVkCDj4WOCRShXHlQc5PcE/CbKyClgaoZofNDn3WVria7e65LsJBWsW1+XqrPQJ16Hk2lJbybqWRk+yHCJbXfmyOBA3PcTltygJxbPupgJHi6RFVfabJkUWeHtmJW2nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v1gdY-000457-7b; Thu, 25 Sep 2025 09:43:32 +0200
Message-ID: <2d737cec-8cfa-4a72-9028-4601c3e51185@pengutronix.de>
Date: Thu, 25 Sep 2025 09:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] scripts/make_fit: Provide a way to add built
 modules
To: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org
Cc: Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?SiAuIE5ldXNjaMOkZmVy?= <j.ne@posteo.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-kernel@vger.kernel.org, "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20250922224835.1918759-1-sjg@chromium.org>
 <20250922224835.1918759-4-sjg@chromium.org>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <20250922224835.1918759-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Simon,

Thanks for looking into this!

On 9/23/25 12:48 AM, Simon Glass wrote:
> +def build_ramdisk(args, tmpdir):
> +    """Build a cpio ramdisk containing kernel modules
> +
> +    Similar to mkinitramfs, this creates a compressed cpio-archive containing
> +    the kernel modules for the current kernel version.
> +
> +    Args:
> +        args (Namespace): Program arguments
> +        tmpdir (str): Temporary directory to use for modules installation
> +
> +    Returns:
> +        tuple:
> +            bytes: Compressed cpio data containing modules
> +            int: total uncompressed size
> +    """
> +    suppress = None if args.verbose else subprocess.DEVNULL
> +    # Use provided tmpdir or custom install path
> +    if args.path:
> +        mod_path = args.path
> +    else:
> +        mod_path = os.path.join(tmpdir, 'modules_install')
> +        os.makedirs(mod_path, exist_ok=True)
> +
> +    if args.verbose:
> +        print(f'Installing modules to {mod_path}')
> +
> +    cmd = ['make', '-s', '-j']

Executing `make image.fit FIT_MODULES=1` in a fresh build will result in
a python stack trace, because image.fit only has dependencies for the
kernel image and the device trees, but none for the modules.

Even with that added, I don't think it's a good idea to have make call a
script only for it to call make again.

Instead, there should probably be a modules.cpio.gz make target or
similar in its own right and image.fit should depend on it if
FIT_MODULES is set.

Thanks,
Ahmad

> +
> +    # It seems that the only way to prevent a 'jobserver unavailable' warning
> +    # is to remove it from the makeflags
> +    env = os.environ.copy()
> +    makeflags = env.get('MAKEFLAGS', '')
> +    env['MAKEFLAGS'] = ' '.join(f for f in makeflags.split()
> +                                if not f.startswith('--jobserver-auth'))
> +
> +    if args.build_dir:
> +        cmd.append(f'O={args.build_dir}')
> +    cmd.extend(['INSTALL_MOD_PATH=' + mod_path, 'modules_install'])
> +    subprocess.check_call(cmd, cwd=os.getcwd(), stdout=suppress, env=env)
> +
> +    # Find the modules directory that was created (e.g. due to dirty tree)
> +    base_dir = os.path.join(mod_path, 'lib', 'modules')
> +    if not os.path.exists(base_dir):
> +        raise ValueError(f'Modules base directory {base_dir} not found')
> +    dirs = [d for d in os.listdir(base_dir)
> +            if os.path.isdir(os.path.join(base_dir, d))]
> +    if not dirs:
> +        raise ValueError(f'No module directories found in {base_dir}')
> +    if len(dirs) > 1:
> +        raise ValueError(f'Must have only one module directory in {base_dir}')
> +
> +    # Create initramfs-style directory structure (usr/lib/modules instead of
> +    # lib/modules) and move modules into it
> +    outdir = os.path.join(tmpdir, 'initramfs')
> +    new_dir = os.path.join(outdir, 'usr', 'lib', 'modules')
> +    os.makedirs(new_dir, exist_ok=True)
> +    shutil.move(os.path.join(base_dir, dirs[0]), os.path.join(new_dir, dirs[0]))
> +
> +    if args.verbose:
> +        print(f'Creating cpio archive from {outdir}')
> +
> +    with tempfile.NamedTemporaryFile() as cpio_file:
> +        # Change to initramfs directory and create cpio archive
> +        with subprocess.Popen(['find', '.', '-print0'], cwd=outdir,
> +                              stdout=subprocess.PIPE) as find:
> +            with subprocess.Popen(['cpio', '-o', '-0', '-H', 'newc'],
> +                                  stdin=find.stdout, stdout=cpio_file,
> +                                  stderr=suppress, cwd=outdir) as cpio:
> +                find.stdout.close()
> +                cpio.wait()
> +                find.wait()
> +
> +                if cpio.returncode != 0:
> +                    raise RuntimeError('Failed to create cpio archive')
> +
> +        cpio_file.seek(0)  # Reset to beginning for reading
> +        return compress_data(cpio_file, args.compress), cpio_file.tell()
> +
> +
>  def process_dtb(fname, args):
>      """Process an input DTB, decomposing it if requested and is possible
>  
> @@ -318,11 +414,12 @@ def _process_dtbs(args, fsw, entries, fdts):
>      return seq, size
>  
>  
> -def build_fit(args):
> +def build_fit(args, tmpdir):
>      """Build the FIT from the provided files and arguments
>  
>      Args:
>          args (Namespace): Program arguments
> +        tmpdir (str): Temporary directory for any temporary files
>  
>      Returns:
>          tuple:
> @@ -344,20 +441,29 @@ def build_fit(args):
>  
>      # Handle the ramdisk if provided. Compression is not supported as it is
>      # already compressed.
> +    ramdisk_data = None
>      if args.ramdisk:
>          with open(args.ramdisk, 'rb') as inf:
> -            data = inf.read()
> -        size += len(data)
> -        write_ramdisk(fsw, data, args)
> +            ramdisk_data = inf.read()
> +        size += len(ramdisk_data)
> +    elif args.modules_ramdisk:
> +        if args.verbose:
> +            print('Building modules ramdisk...')
> +        ramdisk_data, uncomp_size = build_ramdisk(args, tmpdir)
> +        size += uncomp_size
> +
> +    if ramdisk_data:
> +        write_ramdisk(fsw, ramdisk_data, args)
>  
>      count, fdt_size = _process_dtbs(args, fsw, entries, fdts)
>      size += fdt_size
>  
> -    finish_fit(fsw, entries, bool(args.ramdisk))
> +    finish_fit(fsw, entries, has_ramdisk=bool(ramdisk_data))
>  
> -    # Include the kernel itself in the returned file count
>      fdt = fsw.as_fdt()
>      fdt.pack()
> +
> +    # Count FDT files, kernel, plus ramdisk if present
>      return fdt.as_bytearray(), count + 1 + bool(args.ramdisk), size
>  
>  
> @@ -365,7 +471,12 @@ def run_make_fit():
>      """Run the tool's main logic"""
>      args = parse_args()
>  
> -    out_data, count, size = build_fit(args)
> +    tmpdir = tempfile.mkdtemp(prefix='make_fit_')
> +    try:
> +        out_data, count, size = build_fit(args, tmpdir)
> +    finally:
> +        shutil.rmtree(tmpdir)
> +
>      with open(args.output, 'wb') as outf:
>          outf.write(out_data)
>  

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


