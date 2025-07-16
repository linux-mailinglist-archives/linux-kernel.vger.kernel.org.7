Return-Path: <linux-kernel+bounces-732828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB87B06C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E26504560
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A739274B4F;
	Wed, 16 Jul 2025 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh/cwN2y"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D80211A35
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752638112; cv=none; b=fCRP9OEzUe6tGHWh77lsp2+YyZV1vFhQC72oSIZKsxAsJ6Go+JJ+t21Ugfpclg5pQPBEOHBvKYk07ESCgTKpYdTIrQLDBBfRn30VCw+zNrG7hJUCcBLJxMivuLQYAXdKhMD5Regil+HR9bjE/PvrPFIa3cv3NrYCZjN/3ESMJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752638112; c=relaxed/simple;
	bh=Y+1t2AOF2L+Z+/6/wW1jWnpCe5f34q0RyL5QxDNCMUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+dPaqHiLw2GUa+hd7ug3oaxFikJYfVMjgTbSfk/WDD1/WmJtQQunW/1H2Ny7Z6uHgDhKW0NH8lMtuguXn5TgL0DnZr/rTXnIo1s0eGQnK68019+0au1frwiedqGhB98eH8TOKR7R2pmqEZJylhv4o4vQX9p7WjouyjMDkpqJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh/cwN2y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso7120747a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752638111; x=1753242911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrjV/KKRB0OFouQw9KcTem0jmFXazGKAwtbtltSr+rk=;
        b=Kh/cwN2y7nMArzzCdbYitFy4rP7Hf9Chm+l1/HUB5A1R9VyIBRfqCRj8ftzaB2O6AY
         TKUxGEIxBZL++lE5pnQLOyHLLqEEHcDa6XJotEzMJikcBBpP6a4riCz0ZgYdUBmuEOb4
         j7PK6XsVNqoifP5sceQTnsC7HNdhZdB+oKFKMwLh1C8WSuVZIyxI+Qv1SMexGC9o48Ap
         59k3yWzUer7R5YYQO7ODEG0iW04/rpiWAIBcnj/SEuq0p2exKw1LCI6uM2pn8kIwjdy3
         e6Sbq04tbLTxZPz9K9crfjxrqh1+d7DPOtLI7L8nSGlTTrzjCpwrH5XSdVtJTWhQGTlf
         7KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752638111; x=1753242911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrjV/KKRB0OFouQw9KcTem0jmFXazGKAwtbtltSr+rk=;
        b=QrigdypyFNQWaUD2z8y8Yh3IIN2g7u44+VgGlXGOPKHY1ZL1IExR0u3DqD+uq1vzfX
         xALQlmqp3Oz1bjYJgSN/4XqiqjslLmDHt6DmaTT2JqD1ufdqFTpCB/HdMZGL5NiqoGic
         NiymE0mP3Lxw4BYKiZF52JlMKXpdXB3pQgA5s0P805APB4wfri7BMYlYDEZiciZOKFsb
         PfZXo5lfn2FXLi2Glg9wTshTwBh5VAI28B/WsOcwA/T9XN8WhUsUJVE8YwPyAJyKWyZU
         sqQOX1dr5cZBQcmMR69gGD2aQytJ+QPHQDincuc3u/NSNmn443rhW1jZHyywE661B+2S
         WvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7FM/ECTEdB0m0FZ3PUF/ARRStWNkp1OKLYd1erJXWX4LyQDQlLWe+LuIhOJTPkts5aGaEin6R1qx3ZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8x5kawdhEQnzZtilRYATXH65TCEIpCZq6YBpWG7RdtCC1+QEG
	ehqIa1SsiAiDmps5N4Oxck6dSV49CVHAuEU1HuUvqCIjkvr4kYnSlH/7
X-Gm-Gg: ASbGncuTKp/JS8XRHrsMct3MHMpZsN0IkfuM/l0oHARoKaP/IAMzacPVU3j45arnOi6
	zdpXsxA7pigQOVBI2Kg89Jvo9RES/IJS0vhUmG3MdewLKXmB37lyY97VwfFdH5uforTsqyNM0mE
	Gtr7rN6ARzzbIWY4tIDNDo+UfZSixQbuFmQFCvhESZXcts3gaYOex4SxKfixs9PhA4qiJjgPTQD
	13VBNY8hxECpTTjZ3xoTagSGNIiEsd/A/XnJW+TtotEve3ILcU9kBM/ODl22Cl/hkxKh1/ADP6+
	+m3S1oxSVm8FMj3r48DwvnPcjFDHrdFcdN4t3k+lQmVGHO8GkEIzbgoV6rA4qLW0UmqE6mA9Wen
	qvk2BHWyDZFDU0a5nn29FxSerqhIrguATD/KaWFm6wrtB610/JvCr3VEf
X-Google-Smtp-Source: AGHT+IEPL/VhhD2cwuwvK13zQJpP2yhFG/Ai6R+V7m+OTbC128ahb/mHMrGL0AL53SRcIzpj0mWl6g==
X-Received: by 2002:a17:902:ce03:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23e24f473c3mr19962815ad.30.1752638109051;
        Tue, 15 Jul 2025 20:55:09 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332cdcsm116452485ad.145.2025.07.15.20.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:55:08 -0700 (PDT)
From: Tianxiang Peng <luminosity1999@gmail.com>
X-Google-Original-From: Tianxiang Peng <txpeng@tencent.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tianxiang Peng <txpeng@tencent.com>,
	puwen@hygon.cn,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Li <caelli@tencent.com>,
	Hao Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH RESEND] x86/cpu/hygon: fix missing resctrl_cpu_detect() in bsp_init helper
Date: Wed, 16 Jul 2025 11:55:00 +0800
Message-ID: <20250716035500.3101551-1-txpeng@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250623133116.GDaFlXJMf0xA5fh5JH@fat_crate.local>
References: <20250623133116.GDaFlXJMf0xA5fh5JH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your feedback, I'm sorry for the delayed response.

On Mon, 23 Jun 2025 15:31:17 +0200, Borislav Petkov wrote:
> > Since upstream commit 923f3a2b48bdccb6a1d1f0dd48de03de7ad936d9
> > ("x86/resctrl: Query LLC monitoring properties once during boot"),
> 
> This commit is in 5.7.
> 
> You notice the issue only now because you were on an old kernel before and
> moved to 5-something, which is >= 5.7?

The issue surfaced when we migrated our 5.15-based kernel to new Hygon machines
supporting X86_FEATURE_CQM*. Our older Hygon hardware lacks this capability
(manually verified).

To confirm the behavior:
- On new Hygon machines, both 5.15 and 6.15 kernels trigger the div-zero fault.
- Applying the patch resolves the issue consistently.

On Mon, 23 Jun 2025 15:31:17 +0200, Borislav Petkov wrote:
> > resctrl_cpu_detect() has been moved from common cpu initialization
> > code to vendor-specific bsp init helper, while hygon didn't put
> > that call in their code.
> > 
> > This triggers div-zero fault during early booting stage on our
> > machines with X86_FEATURE_CQM* supported, where
> > get_rdt_mon_resources() tries to calculate mon_l3_config with
> > uninitialized boot_cpu_data.x86_cache_occ_scale.
> > 
> > Fix the missing resctrl_cpu_detect() in hygon bsp init helper.
> > 
> > Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
> 
> Your From: is Tianxiang Peng <luminosity1999@gmail.com> and that will appear
> in git as author.
> 
> Do you want it to be the email address you have in the Signed-off-by instead?
> I.e., your company.

Apologies for the gmail sender address, corporate network constraints require this
workaround. For the git author, I'd appreciate using my company email(txpeng@tencent.com)
instead.

Regards,
Tianxiang Peng

