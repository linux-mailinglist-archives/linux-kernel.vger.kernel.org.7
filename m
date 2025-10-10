Return-Path: <linux-kernel+bounces-848400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A0BCDA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7ED541985
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204C2F7465;
	Fri, 10 Oct 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvKMoVfk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30F2F3C20
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108368; cv=none; b=EXHVNY3VtvkLJZbRhBtqRAN989EYV5nsBE/t27c7sMtFdukbe/XisszRBSquyeaEI1Vdp0fWCcFpk7+Jl3PGR15jGtGgXiRqCPKKAbBRhAM/rqx9wz3dwneE3ohxlYNekdxoOsfIrickwlVbVr1FMPDret4cEW0rG9SnIuy+8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108368; c=relaxed/simple;
	bh=2lQSuBC0hmf5QQsPY8EJacs+HLsLw/rvuQ9Bry/tXw8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l5BaSKxv9UMWw4fWk8emeyOFs5TzEIjDwqjPcz/ZUY0hTpSguMi54bT9Z6u3bA1ysRJM+EsWUcPLMgyCmOerk7DXZUZdr8w1GPKpAvDC34oL/DE/hmiNRR1H/+gyf/uwhTqQwcRh1s8yhKTz+lmOqlDDOoKWxC5gu9Rn5Iq+NGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvKMoVfk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso2282899e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108365; x=1760713165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2lQSuBC0hmf5QQsPY8EJacs+HLsLw/rvuQ9Bry/tXw8=;
        b=VvKMoVfkvehCLpQFbd9kS+zN0mpnkzdyHdbY1XZVEKZZpSjJyuanTXaBdO8gPI2XMm
         Yxh4xZolER6oTajl2vIY9268esGthkyO8Qaw7LZPKTunmJSnt0OUXshfEi+aIkUToe+/
         97USoA5ArvcGbdyW6Ln27VnxZJ0GdPOoe04rAkFO6P2WaObi5AoI532zPrhoSfuRSdeR
         A0uEE03q3DdUGS5ECQ7EbV/Vo2g0ke2ILdDvfbPOFTMJGeXWZvCh6u/L6zZgSj1flkHC
         KbRFcAD8AjeWN61XwSXlICuYmg2X+S6t7Aq8+JNiSEq62IW97o4KEj60Eoc9mPCUepC5
         zncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108365; x=1760713165;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lQSuBC0hmf5QQsPY8EJacs+HLsLw/rvuQ9Bry/tXw8=;
        b=DGHVd/ukH9P0DqViis3V4ij7ZrV3+NGbT5w/NjTyNo1Aik7kQ6ajvOQLimvpJjbVae
         SsjCwSE7Sb3C8dV05AIXDQfs3ztdVhvMrpShpibwuJjPAnynCmLjOe1fEVpRwu0z69OL
         eC4NIRVsS5hXhfiLHBkEfC6jEcgbdBXUBE9n372COZKmtPZ4bwluo0zZPBgCK07zp4c3
         Lz/kct74W6E8vqZ137h6kQSKkXUlvKmMrUuDVDdADGf+28CDn9HxXJwUbvT4+UR21Duz
         m/rdWulwE/9EzOEe99vbYUbkZqbZMHYpv43fI1OD7miyeRVwgqB2I0Ei+XhunS33gkf0
         RQsg==
X-Gm-Message-State: AOJu0Yz9kJx/TlMudv4mipNSOadQEzXey2ExYwzFxY5rDeaoqiZmzLmn
	vNSiwl3tyEpaQR0cL46YoIJq44IPeptj9GoFgMWXINFy4+m/sddDGcag
X-Gm-Gg: ASbGncv552lESI5khDmawI/UvU2LMgqx9Aj5eOmpakKj/vyKacBbKWUagWPOCgpr4Br
	tP106EfQdwu20b056DhS7a1uqucpO52bObBaHkbtHKyrAXS+QZop9Udu8+nQaDwaps2upnLzp+H
	EJZtLiIyv3QRF3450hXiBMHSAr9TbO2SGBPu7Sb7j96wQxitfgrAyKFkiF1rfoZFHye1aih1ETy
	8PiITCOo515EQFKIr+SqYiprD6w77RnQ6/g/Es0m5SivMd1Lo4LZburDjhEXNolcbO4vGqcHRbS
	YUZ5U8+pTNbiQ/ZP5v0L7BbfD8rYj6Oq0YMC5zWP4yihT+8dJEzGCCVDZLpITRI9GgN20eS1HZ5
	QPmTttZ7/0U3gfdZkn3t0lhkVljc6luSm2UkJbacltdIy
X-Google-Smtp-Source: AGHT+IEyiarTdh63zKJ9HB0s5ph6A2gR5sBk0SheGADm5fAiwvVmCB4OTT7gtA49G+1Q9Uni80zbvQ==
X-Received: by 2002:a05:6512:131d:b0:57c:578e:c84e with SMTP id 2adb3069b0e04-5906d8a2c30mr3034156e87.21.1760108364802;
        Fri, 10 Oct 2025 07:59:24 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e577asm949718e87.11.2025.10.10.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 07:59:24 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<87zfa016bd.fsf@osv.gnss.ru>
	<CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
	<87v7ko11iw.fsf@osv.gnss.ru>
	<CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
	<87plav2186.fsf@osv.gnss.ru>
	<CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
Date: Fri, 10 Oct 2025 17:59:23 +0300
In-Reply-To: <CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
	(Fabio Estevam's message of "Thu, 9 Oct 2025 19:40:13 -0300")
Message-ID: <87y0piiz04.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,


Fabio Estevam <festevam@gmail.com> writes:

> On Thu, Oct 9, 2025 at 6:51 PM Sergey Organov <sorganov@gmail.com> wrote:
>
>> What defconfig did you use?
>
> mx6sxsabresd_defconfig

OK, sent resulting u-boot image off-list.

