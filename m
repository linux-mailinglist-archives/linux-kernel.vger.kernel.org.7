Return-Path: <linux-kernel+bounces-758676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA3B1D27C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AF18C67D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78B221545;
	Thu,  7 Aug 2025 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="AAijQIdX"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2141DDC2C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754548233; cv=none; b=VfC/X35/VxsiUtejR2qweYa5/uG1vvxgJsfF+5DVs+L45beUO8gHBugaBimksCbd4xHIgUeXb7zXiTjRWjOSnRNTmVxBjt4erc89dQqXZPahkjKNA3sFfhoC2pHkCWq8XDdv6f1zhb4Z/6clkrl4dThIXDfCD/rm8VDwtu5tSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754548233; c=relaxed/simple;
	bh=W4Ntc/RXCgzof9r/wW7PYUdE+EvS34VpqJHY8J5Ynjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV1tkfoq5YPbipJ7OmnWwD30GRHW/r1PcB3+EhJjVUnooqezn9T9riRDS6WUOjJzLDzJ/Fu2oMRF/35JqFmm3659XfzKWcHgWZFH7cABS2bUU0Daw1mLt2rkoAibZXoA/HF65TU45yzKVyDzdr99FQvQpbhyTTvHFgjMZGoCTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=AAijQIdX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31effad130bso576449a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754548231; x=1755153031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NHg/kg8wRYm35acAFO3iPCap79otzywrEHg5wfyd+eA=;
        b=AAijQIdXYywNmBPLsCeAtVg0GiPGyVqIHUuJN+DjHpXqA/txzuIaX3kPM7RulvG+gN
         KIP5Ru6n9CieTrGeky9uELtFXvBcG52EwNUJeVxlznRyrkhwmkr0ucvcWlAXnzmOqMWs
         5+bdpFEYqSK5DYEtPXZlEP8jm0nP+k8VF0iKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754548231; x=1755153031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHg/kg8wRYm35acAFO3iPCap79otzywrEHg5wfyd+eA=;
        b=EbO02ssNLpC8yssaDqJGS4EgVmnK+6Ap0PVk4psPQ0bKEjD2TKY73BW2jkOZv76oDb
         /aLVDLawJgAV29azAuCVZxA1Yt3TKMfFxXcscEKsvBIw2ohOlAfm6M3R5GEs6LEMQ/l2
         6ZybCJUhaZ0V54LvQkYP6ri6z7AiFFp63NrrldEmufXWT8YBUWlvAZuXlrsBoYdPCHrE
         n8Tx0kX6APlyCXSVD3TtbuzGgFwDKSY00ypO+8+/NrWC+LyUeARMQ+6OwLW+TBK9tblq
         Y6ZBLu9175P/ms2+gEYGkGPimmWyEkAOHTBugLAV2eR/LpqI9dNyDFbJf4BT+pU8lIWY
         FPBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdLB+tvzs/eoonm6E9EnIWoJmBXsSh/uT29y9QYCqWSN5G1pihV5hbJpi6FZBRTKl7dY8KU1UCPJerVJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1o37CqCm/xz12QwMIvORG156KELyNI91XlN+u6jXMd/p3XgG
	HtCvkVADdI0pSR+/0jYZyezrpjfW3GoHZZ2Rnsx2WJLRwksQYDNtDP4YcKrV6sM3/hc=
X-Gm-Gg: ASbGncvlHJ1FdrLgSQr14MmQdmU4LT02m7j3ix2m3Y4xR0ZYw1w/ZmKG2KrGDDV/qho
	58ezkpeTWukYoHshy9rWxTqlMnCXZgODeJzKY5PJOqUfVcTKt80fnulHuCbRRKGIRr4U677+O3n
	43edl4ls1CvMFdFvuWqtDxNBGh/t+J/fzN0aNQX3a9O+8Qw88wfb1U98STf+v+I8KV18sypH7ex
	MT1L+A1zTFDY7Qpz+xhKt9obCDCjOw/x/DLWCj7IrTzZMFvIBmyxz5IQ4FSegc2lsJgsoVb3FGd
	bKgDZ7/5lFzJXmtF6T9lGNS5GsUCy0MwjBIFBGnxDosv8RBhJ3swh5hiKl003VdNObjalDsNbTy
	Z3GGk9DARdWLiDg7B04XSTEHvpiXP6Pxz1AJ3Gu3/ughhV/5vCJoTvyRe
X-Google-Smtp-Source: AGHT+IFyhmlc2YddIOuQEtwwCm37dwdpwh/ZM6p9/UE2n0ZuCrgqX9U0YOdGYYTtZz7OZP7SEVvq+A==
X-Received: by 2002:a17:90b:586d:b0:31f:1757:f9f8 with SMTP id 98e67ed59e1d1-321675202f4mr5934157a91.22.1754548231043;
        Wed, 06 Aug 2025 23:30:31 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f33e58sm21352178a91.33.2025.08.06.23.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 23:30:30 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:30:25 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] samples: rust: rust_misc_device: add
 uring_cmd example
Message-ID: <aJRIAUwlIJkJ9jxV@sidongui-MacBookPro.local>
References: <20250727150329.27433-1-sidong.yang@furiosa.ai>
 <20250727150329.27433-5-sidong.yang@furiosa.ai>
 <B650673C-E2C8-4382-A86D-CD44840F5B21@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B650673C-E2C8-4382-A86D-CD44840F5B21@collabora.com>

On Fri, Aug 01, 2025 at 11:11:44AM -0300, Daniel Almeida wrote:
> Hi Sidong,
> 
> > On 27 Jul 2025, at 12:03, Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > 
> > This patch makes rust_misc_device handle uring_cmd. Command ops are like
> > ioctl that set or get values in simple way.
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> > samples/rust/rust_misc_device.rs | 34 ++++++++++++++++++++++++++++++++
> > 1 file changed, 34 insertions(+)
> > 
> > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > index c881fd6dbd08..1044bde86e8d 100644
> > --- a/samples/rust/rust_misc_device.rs
> > +++ b/samples/rust/rust_misc_device.rs
> > @@ -101,6 +101,7 @@
> >     c_str,
> >     device::Device,
> >     fs::File,
> > +    io_uring::IoUringCmd,
> >     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
> >     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> >     new_mutex,
> > @@ -114,6 +115,9 @@
> > const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
> > const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
> > 
> > +const RUST_MISC_DEV_URING_CMD_SET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x83);
> > +const RUST_MISC_DEV_URING_CMD_GET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x84);
> > +
> > module! {
> >     type: RustMiscDeviceModule,
> >     name: "rust_misc_device",
> > @@ -190,6 +194,36 @@ fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result
> > 
> >         Ok(0)
> >     }
> > +
> > +    fn uring_cmd(
> > +        me: Pin<&RustMiscDevice>,
> 
> "me" ?

ioctl() uses the args name with "me".

> 
> > +        io_uring_cmd: Pin<&mut IoUringCmd>,
> > +        _issue_flags: u32,
> > +    ) -> Result<i32> {
> > +        dev_info!(me.dev, "UringCmd Rust Misc Device Sample\n");
> > +
> > +        let cmd = io_uring_cmd.cmd_op();
> > +        let cmd_data = io_uring_cmd.sqe().cmd_data().as_ptr() as *const usize;
> > +
> > +        // SAFETY: `cmd_data` is guaranteed to be a valid pointer to the command data
> > +        // within the SQE structure.
> 
> This is what core::ptr::read_volatile says:
> 
> Safety
> Behavior is undefined if any of the following conditions are violated:
>     o src must be valid for reads.
>     o src must be properly aligned.
>     o src must point to a properly initialized value of type T.
> 
> You must prove that the pre-conditions above are fulfilled here.

Okay, I would describe pre-conditions.
> 
> > +        // FIXME: switch to read_once() when it's available.
> > +        let addr = unsafe { core::ptr::read_volatile(cmd_data) };
> 
> So drivers have to write "unsafe" directly? It isn´t forbidden, but
> we should try our best to avoid it.

I don't know it's the best way to use &[u8] `cmd_data` in driver. The driver should
cast the `cmd_data` to user structure i32 in this time. is there any safe way
to provide safe interface for user driver?

> 
> > +
> > +        match cmd {
> > +            RUST_MISC_DEV_URING_CMD_SET_VALUE => {
> > +                me.set_value(UserSlice::new(addr, 8).reader())?;
> > +            }
> > +            RUST_MISC_DEV_URING_CMD_GET_VALUE => {
> > +                me.get_value(UserSlice::new(addr, 8).writer())?;
> > +            }
> > +            _ => {
> > +                dev_err!(me.dev, "-> uring_cmd not recognised: {}\n", cmd);
> > +                return Err(ENOTTY);
> > +            }
> > +        }
> > +        Ok(0)
> > +    }
> > }
> > 
> 
> Who calls this function?

This function would be called in io_uring subsystem. In detail, there is caller
io_uring_cmd() in io_uring/uring_cmd.c. When io_uring subsystem noticed that
submission queue entry which has uring cmd op pushed to submission queue, it
would be submitted and actually calls this function.

> 
> > #[pinned_drop]
> > -- 
> > 2.43.0
> > 
> > 
> 
> - Daniel
> 

