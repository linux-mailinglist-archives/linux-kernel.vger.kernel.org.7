Return-Path: <linux-kernel+bounces-774196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A6B2AFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5139618A7206
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3F2D2494;
	Mon, 18 Aug 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Avb8ppTA"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D42D2492
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539360; cv=none; b=DcP+9Nxo8gBkpKZHZ9Ll9eYDFVvlrc7X7YztuSGskuob5RlR+y+kfd/hEs15XJ8pOJnNkZdHRxZdNPRrvfH+PusO1sQEjv02fuHaaui8/LX6OKZn3Ku9AIagdaptn6Yne3ZP2RUx4+E5u4ccN9kMF8Kbh2mErhpgGjc4mcOOSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539360; c=relaxed/simple;
	bh=avhZlMlytffs8eDq9Yxr30Bul/Qul7LvNBG7HF1awdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObnBE9e9G5GYdjAtmL/g4xnfoJbnfFTwFcV+OvYQNwdMqukn/xFZEGM+U1S0SfQ2uDH6bpdgsz3UZRlxa8LkubDZnkizMymw7KWw2ZrnhsaCIrakp/Nos4ddLkNtHWfk4g/8H4mfo7axpYs+PkXAT67F4tbS2uPZGu95Y5Ewyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Avb8ppTA; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30ccea8a199so3627626fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755539358; x=1756144158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDrRY1a3eD70nEH48RKnWm3sIwnJhkO0sr03IuSWZCA=;
        b=Avb8ppTAbKWczD0DiGF6mAwhWUxtusFfKRfO2fcYMCJmeSokcgCGqwR5oqb4cAI6Xt
         IWaxNEVn95HGG0BUQBlqVchYlAS4gmRfxDN0sr7/j9i/TzwLVoL+AIah5NUJlDohZEjE
         N6XmoD+TppXd7Md7F+wWtgblM0fsywfWKAHYn+e1UIq0J1GMA6bYNFWOshZMKdNuJ3Cg
         534g6IWTNHpP2E0Xz34YTgGo8erVXnfuAIHmJkvA+wlUUGJU0r1KTXjORy/u2jXofM4i
         6kmLNvoOaDkLlLzE0ztTqGn02UetiGFJmUlpkYnUnTcLfYsMZMFtqQGO/HemsDvkRqEU
         SC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755539358; x=1756144158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDrRY1a3eD70nEH48RKnWm3sIwnJhkO0sr03IuSWZCA=;
        b=kXItqz1bZiV1vTsi//oKqYtRTQggpNsRJ24UC7JLwIfiMth7djpyds6/F65D0luiZ6
         z6g6Xb1G/59VVixpCJVOvZpeB/teSkOGe8onuxSnToHnHEVQ2YrPnNTjJKAyi8n5cOkx
         YnP6ouXSq72OSecCDKi4OdLvEse4FJxzNTtf4J9dpzQSw4wUUX2lqp+EHWsPvUMjhjnb
         0pvPUtxgpINNBne5vhuFrJ2XvZTZT/GiVqP7oNFssfC72/q03VXHeQwrCJRpL7LCb/Uj
         PpwPf0C67YhlMaksNmJfGUWtbaNWO2LMpeowxMf17klVKKc8SCa0YOGQGXwtinVVnXIK
         6k7A==
X-Forwarded-Encrypted: i=1; AJvYcCX13hMgmdKvl52VHZd+SOBuw8wzX6joui8W7Hdc7RLfJ1pJhmPOyG+16YTJSDJbAi4ZUgygcK+gVfxfWUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypA8kFbvrSgLbzY46oZszrez+9oLX1vn4hyswPdlGlxrbuLJuf
	Oo5ZmgGEEUoItendipLonXyis9fYoDQ//RcZ35cvrWxXZ1vBT9+gIfG5AuHnGbEhnBQ=
X-Gm-Gg: ASbGnctPcC6Fcxl329s6uzyjj8IY3tAtq+AhjncOupoKWWhTl9iqZrPf+VBU+u7HvyH
	hhgwTlJzoAT61wwueBZWzWKd8Kwf9f+8eQq2ky0fPGDNbaVLHB1SVlv/t4k/JzsjRG70IRa5/GV
	Mf+jc0SUAtsvXYQ5EF5slgdmf3OmiMco22ik+iBSaBSSx2I3L0XL1gtpew5ZJIEBEwbqCftzusv
	81Y9YLslcXyx62uqbj5wuf99ddZsCir+HpsKo+rBrj5cOmzR47ItzB+4ZeQmO24a6yuIKwAbkIO
	QVPq90kXyr1OY00SOvN/TpDJSJ2RNDPJqAzYADInYxULVhyHi1V6U267MkzLTL5+OVsR2P2ViKW
	+M4LxMPbfstR7R3z/rb9ZvE/Up3GSYCIzyCCDbQ==
X-Google-Smtp-Source: AGHT+IG2jil+KbINlTXXuYPM8rlFZjBn/ogoNsACYdIeZ8sTCyinbwXeeZaK2g5ZcKKVupCYIqzjUQ==
X-Received: by 2002:a05:6870:fe89:b0:29d:c764:f873 with SMTP id 586e51a60fabf-310be68eb90mr6516819fac.31.1755539357761;
        Mon, 18 Aug 2025 10:49:17 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abb34366sm2777416fac.23.2025.08.18.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:49:17 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hch@infradead.org
Cc: ethan.ferguson@zetier.com,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: [PATCH v2 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Mon, 18 Aug 2025 13:49:11 -0400
Message-Id: <20250818174911.365889-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aKK_qq9ySdYDjhAD@infradead.org>
References: <aKK_qq9ySdYDjhAD@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/18/25 01:52, Christoph Hellwig wrote:
> On Sun, Aug 17, 2025 at 10:32:00AM -0400, Ethan Ferguson wrote:
>> Both e2fsprogs and btrfs-progs now use the FS_IOC_{GET,SET}FSLABEL
>> ioctls to change the label on a mounted filesystem.
> 
> Additionally userspace writes to blocks on mounted file systems are
> dangerous.  They can easily corrupt data when racing with updates
> performed by the kernel, and are impossible when the the
> CONFIG_BLK_DEV_WRITE_MOUNTED config option is disabled.

That's fair. I took a look at how btrfs guards against this, it seems
as if they use mnt_want_write_file to guard against bad writes, and
only write to the in-memory superblock, and commit the transaction
afterwards. However, this (during my testing with
CONFIG_BLK_DEV_WRITE_MOUNTED both on and off) still results in an
immediate disk flush.

My changes from this thread also seem to work with
CONFIG_BLK_DEV_WRITE_MOUNTED both disabled and enabled.

Maybe an alternative would be to only write to sbi->volume_label (with
mutex guarding), and only flush to disk on exfat_put_super? And to use
mnt_want_write_file as well.

Unfortunately, given that I'm pretty new to kernel development, I
wouldn't know that the best way to approach this. Any thoughts, or
pointers in the right direction, would be appreciated.

Thank you for the feedback!

