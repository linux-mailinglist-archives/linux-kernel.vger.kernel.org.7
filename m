Return-Path: <linux-kernel+bounces-796605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B3B40343
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA431B267B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7131AF2E;
	Tue,  2 Sep 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0r+mbgX"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF231B11D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819505; cv=none; b=QIuaB/cPNOukYxwons6DjuE+fc6XQDlkYZQ3Y7TlBOBL1ecvY5dgBNNq7p+RapNeuaXRHcJeui3GAVHPF0zfnHvhvue3qK2wVTcMPw9NLm9+5TnQoQabU/3uW04u4VShN6J2LcTFaLCflZpSMk18CqG3J7xKjaV6DzJjS7EThCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819505; c=relaxed/simple;
	bh=BpUun2ANVvPiushHunmBcudeDBV2eVvWaSsFWXOZzlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBX+tRUe7YZ52F00bCC+kmFCf2LngO+CPWWBIsU06s17d9YDp2JRc0tJzMChc/jyuFnrFtrdl7TbHSqXs/h/PrHkdbk1QCxe5D+DqIh4AMNk5G6u+I2pLk/7fT2PDF4NNBZW5+sLwjCSZJ37giaUdGqCAZMhL2YmrluZ7GUI3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0r+mbgX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso3312130b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756819503; x=1757424303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAKv3ARY8F+yWKjLMyeFuP0P6iaLiRDW6497o8ZkCfY=;
        b=m0r+mbgXi/oszZPUzOpEXRQDwUjaHprnktC8eg1zl+UFaBp5PqQ7o82kkveilJzuVH
         0jPd2Jp62+hptYp9jc8SzUBMwgjYK3lDrsjwiSC64UQ+FNBPs0dfuUnTBzdi4OPHN8yu
         6xWIq7cIZWYWwINzOKenKntX6eAymC4Zh0QAtUXHF2hpUTA9J+2PJAA+FWScSEhJFUiC
         +zAzvWCXt96LJDzDSgb1QcqfdQUhaZy5h9xfryKrpQpXCthDpkASnAMFv7zmbK1t3Pig
         p9XSNx7z5BZwgr6vCA9lBHC68ORWnTBLT72c+0UpKlEw37s8+lckUAUBa204ALx+v9Mj
         Q+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819503; x=1757424303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAKv3ARY8F+yWKjLMyeFuP0P6iaLiRDW6497o8ZkCfY=;
        b=KXv2Go16Vc49BeXMg8HLbblLdDigxBNLBJ1XMFs3afIshaFAHZgXFz7+0gLB4RO3mJ
         wKjU8UzXIB7nE0WtyxSc1weTcp0rNbDqaf0tlHuK+o0KgSUnWXqgDe11J6YLdCte699R
         CAfaXvkLnE/e1XMibRvGMHo6rOf6HM6fX4MZSp3aimXYZz2ESPGOjXN2PxrQ3MIHA7CF
         JkfuZORpgVVgpFNQlWC+5fte7y/GxXN6WAKPKHp4OVFE2i4VXH1vn9l2Uv/WLa6JXF6w
         W+2fO07TwXAsMzr934G1CKVXLPskp9t8/aCoGQbsSuCbhQIDq0RILMHcGLKSJw/cgQbV
         CTSg==
X-Gm-Message-State: AOJu0YwJNJ1FEbjcGf91wMUZ+tmUvBLwCGGOfMm0D6m3OqaUb40hTKLy
	1bXk7Bs+dewy6avsmc32HM7SV82AHdSNpqjji++mkttBuJUmaq33qBHFFHbN96K6Bwc=
X-Gm-Gg: ASbGnctWpRK8SzknMOvVq3JIyvCkhu/8XyEgNzXSwg87qPVVU9Bc4KT48Zq7LKznNks
	ZtjUOQtDMgsi0chqiC6kAm4RgnONzjwqrVCOH53d9KNJjhd/jgTyaNhWDxiemYcgnuFI/L/dGr8
	YEjAx7oH9bzS15GBOsp06vVXLD4f5ILhPzAS1VaRJveFpubDMDvyJNMdg36sWNUHKIVm55UaVzk
	wRigN8p7Kwxe3MYc00ypgTQuoKIccR0ifQBptEDewRdXXLkGsbwRQaTWS+xzwyUTNYztYFYRNNg
	I6GB/yg3y93+iZjwClmBMo9Cv4FaVSknbs/XookhQ+UTF2Sfvs0VPuJ4WFZsgE8gFzG0WVHuFgi
	Gno6GNFl9BVs9y9ViuxRrPJeUGimGL+qq
X-Google-Smtp-Source: AGHT+IFwznE4uvanrl4ZbgMVbQIBunKzGFHOetqqicoE37fCFL0jOS8qWn7HFQpQ51uikAw7WcygNg==
X-Received: by 2002:a05:6a20:7283:b0:240:168b:31b with SMTP id adf61e73a8af0-243d6dfdaffmr15704372637.16.1756819503085;
        Tue, 02 Sep 2025 06:25:03 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b362dsm13749859b3a.32.2025.09.02.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:25:02 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and fat_mirror_bhs()
Date: Tue,  2 Sep 2025 21:24:59 +0800
Message-ID: <20250902132459.44-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87tt1lowqd.fsf@mail.parknet.co.jp>
References: <87tt1lowqd.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

OGAWA Hirofumi wrote:
> Sounds like strange. FAT driver never read the mirror FAT area in
> runtime. Why did you think the mirror FAT affect to it?

Thanks for raising this point.

FAT driver itself never reads the mirror FAT at
runtime, so this race does not directly cause runtime corruption.

However, if the primary FAT on disk becomes damaged, user-space tools
such as fsck_msdos will consult the backup FAT copies in order to
repair it.  In that scenario, keeping the primary and backup FAT copies
consistent is important.  If they diverge due to a race between
fat12_ent_put() and fat_mirror_bhs(), recovery by fsck_msdos
may become unreliable.

So my intention was not to fix a runtime problem, but rather to prevent
unnecessary inconsistencies between the primary and backup FAT copies,
which can help later recovery tools work as expected.

Thanks.


