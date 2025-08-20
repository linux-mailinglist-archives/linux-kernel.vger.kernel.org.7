Return-Path: <linux-kernel+bounces-776699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476CB2D0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE53B2A72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A413A86C;
	Wed, 20 Aug 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OppL3RO9"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3735335F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649217; cv=none; b=CAya5+CfsGgbGicU+2iONnty9IakG5aOOrkeHdn1e+bOo823601/YefaS0W9TUl47UdEt/tvMriToS5KjFyx/NWzOevYn1kfju1EVqrlXlH7LRwfG05SfDMWvSkyMyPi1ZZl6k2/pa+vR7ccDW4ZuPUPjAOx5lxI+/z9x5TVFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649217; c=relaxed/simple;
	bh=dj/W5l5Iz4khApVd7wZ/FEtk0SzKtA1zmVC7nEcH6M0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TC03b8g7TonMQBI9R3NzSnO47JsM2zHgcZAuIOJkPR+giqhBuc9LCG7eRspQDVmiYoIBPtPnK/uoyL+XOGbdQ327PGIQ6HbpTZCwqswna86I/qc6PB066r4fyxgkIc9EC/aLnpPO/8slaVW1M5x9AHfvqwxZM3pUxXjLH43/4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OppL3RO9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e67dcc0c88so310465ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755649215; x=1756254015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj/W5l5Iz4khApVd7wZ/FEtk0SzKtA1zmVC7nEcH6M0=;
        b=OppL3RO9SuCVjKHp7XTxNarRZHQoo2qgayQZ2Alk0yCscFpSWYhSTm/CB6+2hYNCj9
         GwEmJGhniPErCbhb0bsxNjdTU0smZRA20d0XUkI3nTVzVqQNJCKW7vBnYztW8Paxot5c
         +J6iJLgybuU1vKoZFCXI7SdvCypu0Vo4IxuY9CLvQLc2P7LdnkY6nr0cJ2WQHMt8Pxv3
         7+6S23+FP1UTCVtXIzXi0rNUkATChqrOWwpA4t+R8rfXw4E9LAcO3nGHwlCt+i5uX93L
         jp0I6L32Svh2gyWLubNIFQQeFasWUk3f8WYIspE4acOrvCtKmVRluMqIulV5AbEyFw4p
         PXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755649215; x=1756254015;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj/W5l5Iz4khApVd7wZ/FEtk0SzKtA1zmVC7nEcH6M0=;
        b=H0qi2EGq+qWjHFT0KWlne4z5VFgvXBCWMEppsYlRZ+3NMYhkWhFRu7tsYzwm9dkJ96
         dCEFBbzLpPU3zIIZ8pc2KcmPVMRmNQKh4OV3LKgREMAWMpCR45lEnpuGHCKyZ6EnsTD7
         sjBy0FbwO51dmzJHgbTGxT6QbkeLfOJkJOzbOej+/OoFvrW5qKo80npqVt/Ag4w1OSyn
         UcaU/3MjZlewFa+asnmZ3Ocfu3euJQ3kh3Gy3RTlubUrC1b+fm6oETbKdpAvc4FX33vg
         PA2dqZ2FWZB1I333Lz6DNwEurfylX0qgM8rhSBbJNruUX2GB3fUMPYWwfYHxNOYZeNT2
         CzVg==
X-Forwarded-Encrypted: i=1; AJvYcCVNNEFbJSFgm6RrWesW7b6KIKK1+pB2/WasZIyEvNvjpGyQAWrCu3zr2fo+P7KCcUlsfX42mLbUNmFO520=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3bKXS1tGHCm0xKHcZaBhq7sgk0enDhNnBj/cU8vndTZaktyX
	DbJxuVZj0OY14udZS7kV4EudKu7sd8xfqML9XXfUobgis/xVjcQyXx45qzr/SXKO8LE=
X-Gm-Gg: ASbGnctxxjNijYG7T/n99WCMFrtLJZ50odLvRkZQ9TcgXibxQAtBQmEXk5yT4mK7BFH
	K07tFBvgEEcENB5UIX/u41lJyAuhLCj2j/dF2TcOrcridIy+d1cSceY4/RfF3uqwRUgx+ePmazI
	/h8DPaLct6t0/tWdWYAPb5XmpOcT5agI5ZYZ01VKksROiYETyLxYU/WUXD6zVLf2z3hxb68hkwC
	yngl0aOtYbq7tsEwrJDwJ37Kg+AP0xpnJ+VsMpjvjBtQ70YkXf+52XKcx8pAj0boCxIsZfBPyD1
	R5Qr0dBQePbbIorA6YGoMoo1G3P2Ti2acpwH5/tWH0MHkDv86Ogg4dBEFAMPLbTxxc0RFZ/Jdwi
	kpHK+Rk0Ofx2s/Q9g5UHDydmSVBdnm/OpL/0b/g==
X-Google-Smtp-Source: AGHT+IGbLV7K2oS4CfCrTycPmReNCo2y3ItP/0XiKPdtsaHZ2KX88gHbK8fBAvQFjzW7ezgl7groeQ==
X-Received: by 2002:a05:6e02:2141:b0:3e5:4b2e:3b00 with SMTP id e9e14a558f8ab-3e67c9e6dbdmr19085045ab.4.1755649215202;
        Tue, 19 Aug 2025 17:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([138.199.100.237])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e67d95f76dsm1007785ab.8.2025.08.19.17.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 17:20:14 -0700 (PDT)
Date: Tue, 19 Aug 2025 19:20:15 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Drew Fustini <fustini@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>,
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
 Andy Chiu <andybnac@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Darius Rad <darius@bluespec.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Florian Weimer <fweimer@redhat.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_riscv=3A_Add_sysctl_to_con?=
 =?US-ASCII?Q?trol_discard_of_vstate_on_syscall_entry?=
In-Reply-To: <aKUQXDh4u9xJx+jS@x1>
References: <20250819-riscv_v_vstate_discard-v3-1-0af577dafdc2@kernel.org> <20250819-bb1be8c05ebdf7ea751323aa@orel> <aKUQXDh4u9xJx+jS@x1>
Message-ID: <967A5590-1B0E-4ADF-9947-E8F06CCF14D6@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 19, 2025 7:01:32 PM CDT, Drew Fustini <fustini@kernel=2Eorg> wrot=
e:
>On Tue, Aug 19, 2025 at 12:16:02PM -0500, Andrew Jones wrote:
>> On Tue, Aug 19, 2025 at 02:40:21AM -0700, Drew Fustini wrote:
>> > From: Drew Fustini <dfustini@tenstorrent=2Ecom>
>> >=20
>> > Vector registers are always clobbered in the syscall entry path to
>> > enforce the documented ABI that vector state is not preserved across
>> > syscalls=2E However, this operation can be slow on some RISC-V cores=
=2E
>> > To mitigate this performance impact, add a sysctl knob to control
>> > whether vector state is discarded in the syscall entry path:
>> >=20
>> > /proc/sys/abi/riscv_v_vstate_discard
>> >=20
>> > Valid values are:
>> >=20
>> > 0: Vector state is not intentionally clobbered when entering a syscal=
l
>> > 1: Vector state is always clobbered when entering a syscall
>> >=20
>> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD=
=2E
>>=20
>> I'm in favor of the clobbering being off by default and creating a knob
>> to enable it for debug purposes, but I'm not sure we need the config=2E=
 I
>> think it's reasonable for systems that need the discard behavior to add
>> a sysctl toggle to their early init=2E The config may complicate the
>> documentation needed for user recommendations and potentially generate
>> confusion when moving from one system to another since defaults could
>> be flipped=2E
>
>If I dropped CONFIG_RISCV_ISA_V_VSTATE_DISCARD, then are you thinking
>that riscv_v_vstate_discard_ctl would be initialized to 0 instead?
>

Yes, discard off by default=2E

Thanks,
drew


>I would be okay with that as it defaults to the clobbering being off=2E
>Hopefully, Palmer will chime in on whether setting the sysctl in an
>init script would be acceptable=2E He told me that he does want to retain
>the strict clobbering behavior on his tester machine=2E
>
>Thanks,
>Drew


