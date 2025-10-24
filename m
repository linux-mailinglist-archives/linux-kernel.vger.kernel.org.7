Return-Path: <linux-kernel+bounces-868313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07DC04D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFA9F4FCCB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45F2F363B;
	Fri, 24 Oct 2025 07:51:08 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57ED29E11E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292267; cv=none; b=ClEexo68+GEd2yn/03ceSh4mu0OkOwxViVBKjYpsX7xrs26DNHtnw9j31witF/8QFlexcO3WVnagC3OOQv1VmRKdpHGK+v/JxYvotgE0PFKEGbanu6yWHAmHwBPKGmp8xl7ZnpMLubt4RJ2bJlEprgwDsUUrUIYaNu0sPxOafAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292267; c=relaxed/simple;
	bh=kOIb8pO1VZ73XCvnGHpMiZ9dvlzUJ9175As3iXsBlQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erTKda6Em6KrR941ZTyxn7yOBPetUjYJQsHmtzB8TRSNPQZf4Gryx2r1eV3cpt1VQ1KOIh8AG06R9x/PfV8ku+X8VyuY0CbAAFiCxRVjNAQo1+XqvxfLaWsB2HesV23o41IQsfNoVkCN9Zjr4HY/O8G5meXjcnbwu3YReK0g8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso1108401137.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292264; x=1761897064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEaHKti+4CwOcB/zEpLbx3BHVjwaMqNNfgI/2fVN82o=;
        b=UIwMMM/wtwzjwu5cCtFvvDUdF7Aq18H6i5nZvGTlhtIFjwmoXADC8YOfTlU66maKOQ
         VjECT3k3KU9QoycTQAhU14KsbLOWRn2Nux+6Q0DHtilrdQL3Hrg49F1xifHrgLJUuqm1
         nzJzaTbJ4ECNG7AXKpQP/O08o7ksnP5n/eGsLD/56L1dGcaXwfi28psHpWtciaZCsqjW
         6WIyohHxkk+piF0AR9s0s2s4C/2yqbjSkSMwCh9UPIC7FdkxheBXdpFdGL6VuW6sVAlW
         PcLGkHGQdp7FDJQoWZyLBhapxN5oHLzBgT4oA0bOsGZrYpUp/eSeTtOwb4KwMsa75rQK
         kFYw==
X-Gm-Message-State: AOJu0YwIDQU7Zynifhq8baO+5R9/Qy+/wcE6Q1raO1yQiuq+tk36bj3s
	KB78doxzRinV+IECzaVsL8+S3SfIiqysyMs8bnjxRrMRQIQci5A7Y65l2NEAlQ5v
X-Gm-Gg: ASbGncv+PBMsKj8eeheP+IvJrhLepRVgamdqC1w+Buh/JTGB9ynF7zoZB9yaaOH+nY9
	cIbQip2+eCblwz1u+3twl2q7s4Ny0w2V2TKv6cS2wNr/8sB89SJpqCGuNaoBbVdzytzL4zN/1Sh
	RAjJQx9ReWgAhoHDVpnLCra3Z70Kxjt4nhMISBVcTITRwkFmy8WY/SnqVDp73XvPF+Be45N2JIQ
	T7r0w7lf+Lid40kH2QGMfH4WYTvwoo4Mh435oDDOV6GPF8Ke9lrL9DyiZTvr0o45sFCt2d3KmsG
	rIpeXHkUG2IQ+SlmHM7kFrc5y+5oPZT3xCD2h3bsD2e1WiIFDLeMfTC+QYi/cvRT5O/qO0UVMd5
	t+e4hG+fh1F7v5QgFzQbOrOi5e8Tcjr7lDcel2D+qWtLUeT2RLbYEEIY4aPRaeVXtbiJpsOok3y
	/bNNOA1Osos+nhfDENK20BNUNHDERC/Xii8+cVcQ==
X-Google-Smtp-Source: AGHT+IEp8FgUITlPpmPCYiYQ2KWtRP90tU1PI5cve1oSfpXEVhpiZZXVOc/2DWwqB1v8MkqEgDinCw==
X-Received: by 2002:a05:6102:c06:b0:5db:4006:af44 with SMTP id ada2fe7eead31-5db4006eb51mr263965137.18.1761292264295;
        Fri, 24 Oct 2025 00:51:04 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934abaad7adsm1776588241.6.2025.10.24.00.51.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:51:02 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-89019079fbeso669411241.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:51:02 -0700 (PDT)
X-Received: by 2002:a05:6102:3f15:b0:5b1:15:1986 with SMTP id
 ada2fe7eead31-5d7dd538738mr7885768137.15.1761292261598; Fri, 24 Oct 2025
 00:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
In-Reply-To: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 09:50:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUg5UXRcnH18S8-QtR9y+GbnAcxEQB2EyTOgd=uSUYPTg@mail.gmail.com>
X-Gm-Features: AWmQ_bm2tpX7mJalre9hbsLcHK70ACd_i6BeMhocHaw4n9ctINo2lxr47J4Q4zo
Message-ID: <CAMuHMdUg5UXRcnH18S8-QtR9y+GbnAcxEQB2EyTOgd=uSUYPTg@mail.gmail.com>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing to logs
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Chant <achant@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Douglas,

On Thu, 23 Oct 2025 at 20:34, Douglas Anderson <dianders@chromium.org> wrote:
> The kernel cmdline length is allowed to be longer than what printk can
> handle. When this happens the cmdline that's printed to the kernel
> ring buffer at bootup is cutoff and some kernel cmdline options are
> "hidden" from the logs. This undercuts the usefulness of the log
> message.
>
> Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> and some architectures even define it as 4096. s390 allows a
> CONFIG-based maximum up to 1MB (though it's not expected that anyone
> will go over the default max of 4096 [1]).
>
> The maximum message pr_notice() seems to be able to handle (based on
> experiment) is 1021 characters. This appears to be based on the
> current value of PRINTKRB_RECORD_MAX as 1024 and the fact that
> pr_notice() spends 2 characters on the loglevel prefix and we have a
> '\n' at the end.
>
> While it would be possible to increase the limits of printk() (and
> therefore pr_notice()) somewhat, it doesn't appear possible to
> increase it enough to fully include a 2048-character cmdline without
> breaking userspace. Specifically on at least two tested userspaces
> (ChromeOS plus the Debian-based distro I'm typing this message on) the
> `dmesg` tool reads lines from `/dev/kmsg` in 2047-byte chunks. As per
> `Documentation/ABI/testing/dev-kmsg`:
>
>   Every read() from the opened device node receives one record
>   of the kernel's printk buffer.
>   ...
>   Messages in the record ring buffer get overwritten as whole,
>   there are never partial messages received by read().
>
> We simply can't fit a 2048-byte cmdline plus the "Kernel command
> line:" prefix plus info about time/log_level/etc in a 2047-byte read.
>
> The above means that if we want to avoid the truncation we need to do
> some type of wrapping of the cmdline when printing.
>
> Add wrapping to the printout of the kernel command line. By default,
> the wrapping is set to 1021 characters to avoid breaking anyone, but
> allow wrapping to be set lower by a Kconfig knob
> "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". Any tools that are correctly
> parsing the cmdline today (because it is less than 1021 characters)
> will see no difference in their behavior. The format of wrapped output
> is designed to be matched by anyone using "grep" to search for the
> cmdline and also to be easy for tools to handle. Anyone who is sure
> their tools (if any) handle the wrapped format can choose a lower
> wrapping value and have prettier output.
>
> Setting CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN to -1 fully disables the
> wrapping logic. This means that long command lines will be truncated
> again, but this config could be set if command lines are expected to
> be long and userspace is known not to handle parsing logs with the
> wrapping.
>
> Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> with "Kernel command line: " and lines that are not the last line have
> a " \" suffix added to them. The prefix and suffix count towards the
> line length for wrapping purposes. The ideal length will be exceeded
> if no appropriate place to wrap is found.
>
> The wrapping function added here is fairly generic and could be made a
> library function (somewhat like print_hex_dump()) if it's needed
> elsewhere in the kernel. However, having printk() directly incorporate
> this wrapping would be unlikely to be a good idea since it would break
> printouts into more than one record without any obvious common line
> prefix to tie lines together. It would also be extra overhead when, in
> general, kernel log message should simply be kept smaller than 1021
> bytes. For some discussion on this topic, see responses to the v1
> posting of this patch [2].
>
> [1] https://lore.kernel.org/r/20251021131633.26700Dd6-hca@linux.ibm.com
> [2] https://lore.kernel.org/r/CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for your patch!

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1512,6 +1512,24 @@ config BOOT_CONFIG_EMBED_FILE
>           This bootconfig will be used if there is no initrd or no other
>           bootconfig in the initrd.
>
> +config CMDLINE_LOG_WRAP_IDEAL_LEN
> +       int "Length to try to wrap the cmdline when logged at boot"
> +       default 1021
> +       range -1 1021

Apparently COMMAND_LINE_SIZE is still smaller than 1021 on several
architectures (even in asm-generic: 512).  Unfortunately only s390
still controls it through a config option, so you cannot have a
"depends on COMMAND_LINE_SIZE > 1021" here...

> +       help
> +         At boot time, the kernel command line is logged to the console.
> +         The log message will start with the prefix "Kernel command line: ".
> +         The log message will attempt to be wrapped (split into multiple log
> +         messages) at spaces based on CMDLINE_LOG_WRAP_IDEAL_LEN characters.
> +         If wrapping happens, each log message will start with the prefix and
> +         all but the last message will end with " \". Messages may exceed the
> +         ideal length if a place to wrap isn't found before the specified
> +         number of characters.
> +
> +         A value of -1 disables wrapping, though be warned that the maximum

Or zero, right?
So perhaps just use range 0 1021.

> +         length of a log message (1021 characters) may cause the cmdline to
> +         be truncated.
> +
>  config INITRAMFS_PRESERVE_MTIME
>         bool "Preserve cpio archive mtimes in initramfs"
>         depends on BLK_DEV_INITRD

> --- a/init/main.c
> +++ b/init/main.c

> +static void print_kernel_cmdline(const char *cmdline)
> +{
> +       size_t len;
> +
> +       /* Config option of -1 disables wrapping */
> +       if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN < 0) {

As does zero, right?

You can add a check for "COMMAND_LINE_SIZE <= 1021" here,  so the
compiler will eliminate the splitting code when it is not needed.

> +               pr_notice("%s%s\n", KERNEL_CMDLINE_PREFIX, cmdline);
> +               return;
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

