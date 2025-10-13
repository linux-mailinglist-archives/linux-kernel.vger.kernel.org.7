Return-Path: <linux-kernel+bounces-851387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA44BD6547
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74A0A3505CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF522D3A8A;
	Mon, 13 Oct 2025 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3kIUE1L"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA18296BDE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389862; cv=none; b=rzPGV8FNyZJC/d5E0yhD7XWm2rxkUrplU4cGwCI1xeNA0IrVaByVTHOItcU7EeqykR2AyqEN9D8ENT41btHPNXZ5zlLTpBt/BwAp4TlNtaei7RY/W5gWtYpkIF6y/F27I0MtYaglvl72qpgx9U6fIqkwip3Z068q3/kabJdAaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389862; c=relaxed/simple;
	bh=XRyQ8TvgonzZxSKeTWrQ9Nooy9DyVz1PgDZQ2fk4fok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRteVf2ePxKcsY5RY4smIx7f/PpLkaxESHUMIiMlnBsdJQTYYnM2d4LmDb//M2VKxB+JgWWpWYY7ajv8Rxg9H1NeekOF8HpoOA5dljiS9EwzqY02hsshGXcqxCqqyOX96mUr1jWpWrA1/AWfITT+z2yAD8/RAtAG7j9DPe4jY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3kIUE1L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2907948c1d2so2855835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760389860; x=1760994660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8T7ajPfnJGCZaEQpmGY6bA7JB2Gwt9VaIoR3OH9oz4=;
        b=I3kIUE1LBxVp7tQQ7mVMXqvgWJcA5YePrBBIIKqPeob8MN8mdfkj1I8uz1SYvvdWw/
         FIBIJIzByURcLuGk4HrpIdZ/BxayxxPD/f0p1OG2xis22XHYV0uOSA92ToHxrg0iPTHH
         fwCmIjs6xgnIvkt0IQVsmX6AKQBmQAssjBo0pqGRgtZRenR1VTR9gYy2wjJW5BsQ3Q7c
         8pcsLHLWAX3lz2EdAeST7jLC0nznZ9LYJVVneE7mwiqqZqKgl+GpcMZRQtpT++A1hd92
         a5mYD32YCm38gBoL5A8zMx0pda/fBWmS/zf1AKJc1tSxg6JuOuF3iEcRLbS1w7H6365+
         e7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760389860; x=1760994660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8T7ajPfnJGCZaEQpmGY6bA7JB2Gwt9VaIoR3OH9oz4=;
        b=OpPFPg5yt/PWqlaoMKtQJUeFhcQpBhQ4Nsob0cFrlNaACFkKihMZFLJJ6SVCQS+dGj
         W6SG09ppJrPc10FJgxoN1Rc7AnColoO08rfQ4Vqv24zHjnKWUFEYSzg8lN3hrPcS06ma
         natpiVoO4WA0lvjEL1aytZyRgu86FPLoNrWtpHWzY2LBleiDotbV/Hkgh+ibyOdIvNJt
         0L4xidkgCo77Yna0qV5QFbOif/JOPWQrMrjKAR2EGLjzPGyCm5jm7pYP62MHqcIQBDJg
         c8Gz3er5qcfdPm0VDkB3OVxlgw1EwG3QQNOLlBajCjppjKl6a+HHpCe+9JJDufKWnol0
         UTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeqPUsUT30d5hnx14HdDnUeDlJskSCtdKYLqXr/zKiUgF8kr6/9PjpzyS4jONzr8+1DpO16daMbmlHlX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+cpedWQTRddy+I3H6nnOQg/3JChYda9cTGWo9r2jn2g6YPXs
	6fDWeyIc/EUqvqDgH8D809x9X26FPz4mRPSEF8Ayn0D/Zz6yvErLfodV
X-Gm-Gg: ASbGnctme8Znc0CumsaC8Hmiu8r2NcaCLcesPCAxPcw6ckQf8m32LE33RfY8t4Ar9yA
	9CLhhiWwC9u7wJTGW+bXOTXIO3pr5fY+xrKAf349KN4NoOJw7IDZ6Ug5n9afJjEbvuod0VAjnG7
	3FwECmIP60vAgDTIBWiaPqHyuTkexqse6r0LAx4Yx8zRvtDuLvikSAa5SEdQPLQ31cncgR/ZBCj
	szLGnZjym+8Re6UAdk4tWjTi7VeBu+YtCYHeFT17dfmVgEIyFEeHghR3/BIXW9uc2ATNpf+UuqO
	H7OnsIPDg5/wfnKYU/FtHIa13sofO8l94xA4KuVQT0EJz5U8c3fXXmQD+mQHUb1bhYuNb+Elxu1
	l/6BIRLHgibTJn4BTUUFZlUTiq5vyN0iGUlTLWRUFVbYAeaWFNSUT4uBVf2alEqJ510aPPvxwPr
	daTxLxgHCSW/w7uprjYl1btqfs
X-Google-Smtp-Source: AGHT+IGzrurCKDAHA2puwM3WJeIi/Do07flXwZ7TOycjcONtFRm0A/LHuoQuvrk5xFsQ3N0FJs9bEw==
X-Received: by 2002:a17:903:3c68:b0:246:80b1:8c87 with SMTP id d9443c01a7336-290272dfb4fmr277119205ad.43.1760389860106;
        Mon, 13 Oct 2025 14:11:00 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08912sm141650595ad.78.2025.10.13.14.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:10:59 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:10:57 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lucas GISSOT <lucas.gissot.pro@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC
Message-ID: <aO1q4coXPqU/K6KI@visitorckw-System-Product-Name>
References: <20251013-hid-haptic-kconfig-fix-v1-1-b1ad90732625@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-hid-haptic-kconfig-fix-v1-1-b1ad90732625@google.com>

On Mon, Oct 13, 2025 at 08:54:57PM +0000, Jonathan Denose wrote:
> Temporarily change CONFIG_HID_HAPTIC to be bool instead of tristate, until
> we implement a permanent solution.
> 
> ---

The "---" line here will cause many tools used for applying patches,
like git am, to discard the content below it [1].

Please don't add this line unless you don't want the following content
to appear in the commit message.

[1]: https://www.kernel.org/doc/html/v6.17/process/submitting-patches.html#commentary

Regards,
Kuan-Wei

> Recently the CONFIG_HID_HAPTIC Kconfig option was reported as causing
> the following build errors:
> 
>   MODPOST Module.symvers
> ERROR: modpost: "hid_haptic_init" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "hid_haptic_pressure_increase" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "hid_haptic_check_pressure_unit" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "hid_haptic_input_configured" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "hid_haptic_input_mapping" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "hid_haptic_feature_mapping" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "hid_haptic_pressure_reset" [drivers/hid/hid-multitouch.ko] undefined!
> make[3]: *** [/home/thl/var/linux.dev/scripts/Makefile.modpost:147: Module.symvers] Error 1
> 
> when the kernel is compiled with the following configuration:
> 
> CONFIG_HID=y
> CONFIG_HID_MULTITOUCH=m
> CONFIG_HID_HAPTIC=m
> 
> To resolve this, temporarily change the CONFIG_HID_HAPTIC option to be
> bool, until we arrive at a permanent solution to enable CONFIG_HID_HAPTIC
> to be tristate.
> 
> For a more detailed discussion, see [1].
> 
> [1]: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35inqda3exwzs3tk3ff@oagat6g46zto/
> 
> Signed-off-by: Jonathan Denose <jdenose@google.com>
> ---
>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 5341aa79f387bd0e5a76266b5928d2c978dd81cf..04420a713be085c8871b4d35255fde4cafd8de0f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -93,7 +93,7 @@ config HID_GENERIC
>  	If unsure, say Y.
>  
>  config HID_HAPTIC
> -	tristate "Haptic touchpad support"
> +	bool "Haptic touchpad support"
>  	default n
>  	help
>  	Support for touchpads with force sensors and haptic actuators instead of a
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251013-hid-haptic-kconfig-fix-634df2bdac1d
> 
> Best regards,
> -- 
> Jonathan Denose <jdenose@google.com>
> 

