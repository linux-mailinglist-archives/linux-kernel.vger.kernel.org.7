Return-Path: <linux-kernel+bounces-793792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D4B3D844
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9CE16FD5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443DC1DF26B;
	Mon,  1 Sep 2025 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RiBg0W1C"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A24502A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756701039; cv=none; b=agD3y7iVTSQR/+AaK29pjfJXfLi+fD1JumAzsk8Z3SWU4V07fpRIqDpomzLADjeNK7+7l1vn6ZauJU8Itl4YrtgYgLgqBZXCSOrAd3PvtgBD5Y4w/euYL3qepyOGFJocLp7S7Zykh21R2mMmpJTWU1H9XQFsjtuBlGzxQ583B1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756701039; c=relaxed/simple;
	bh=pSzCqOyvvoq5Jt9kSV5uDNs9QJ567H1LEks3EmaQerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5uFB+Wt6LMC6wvxAJHBVCs5ZGwiWVtfDd95vpM7Ruqij2mvOgsBicpO+myzCRiovKI74Tonq88J3icuGQIslEVqW4om2eeQmZ25Pi7ERvRE4sNjc1gkXPVq/ca872SbW0xQv5g0wqj9ou925GOf32C0QU34F8///1qQH+uAbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RiBg0W1C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0439098469so24177766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 21:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756701036; x=1757305836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDQIe0i3X76egFX6529AeV7wfu/j7t3pxfvYUfSQIbM=;
        b=RiBg0W1CQC8lEI1AHMH/NhUJnlhL3bkIsRQrJA5mb17Y9CnR/oJppR8qqjkzGDDhVt
         2iEpkSG6IJY69ZOyKoWJxytu/ms/zSmUCE+oOpm9f0YJHI5Ih791ImJ0ZOp9ntJIIlap
         fJz6y474yAheTJnG3jLZdrUgnhUjKMiyo6GhCpwg4XpTAiksDnV/k2UHoKRA2vOlU/U0
         jzkb5CWB94Ap338Gf5ngAjK2di2k8aEwizzHnAw3qNnDBJ+GahXvNOwy805c+ZSvxbYG
         tBgsBNLjR08IMfESWGNlaaKsHdL0u7ArrK0eMLG/iXQMQuPfEYZMEr5LHIcsEk7sQ8+D
         jeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756701036; x=1757305836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDQIe0i3X76egFX6529AeV7wfu/j7t3pxfvYUfSQIbM=;
        b=GIoCjf+n7Qfbx/NVj+ulO+0Tdt2RJAhPcNThO7MfjO4/FgyWisuNA0cRXBRN26hdho
         rvyccKVx1IrBq5puimhOO7D480Z9vzCiMQ+OKeG7HSj0odk0QUb6l2wNPB/6YlbO/xcN
         tclos2pCyBhhwstTZORUymHrDGO/Z7wJhrnHPPFyIWcOIV93mOTowdn8kmUWfp/dGWAJ
         vc+elB2UI+mM1oJ27j4wqBywzmpNCg4/Xwuj2kczoCkv9V+xYntNXQMqwJAEAo2Z+r9H
         rUoib7byIRLqUYj5e6nauBe9hFwD/uX10NTOXBn8RvCXN0DmD99IGfhAEtRz+MJqZS0V
         APjw==
X-Forwarded-Encrypted: i=1; AJvYcCUpQT84F/jaoHzbw/6FzVJrU9q1ROfmduQ4kXeOf397ytBxpuiTqeV+v7D6Ns2zWi32hmWxb+Japita4C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrYLEucIFpgzRrFes9VNGUvZOAf1ge2NhQRLBp59OZLZ5UZnB
	rJXAj+9V8oFO96cu/E3BJqEKleDe8Wm2Zne3lBngER1DMf7O7nLco/8VUAIZ2B5khTQ61yh1cj6
	SpS8x/VR1mwQhOufPeN0bSSL6PL67kXQQniQXWkEz4Q==
X-Gm-Gg: ASbGncvaAL/RlabVoS45882NjRnadRwNXxd/HUeKaibBOxpNwuI2N9hdVWjRaKhFy2Y
	Yg6wbn+916S5iDA5QYS6pG0iO0JesyyPNwZb6fJkHfsdRavewkJ6TVReyvv2F0iVRp6XeCFJwGj
	YIF9uetC8MgsD2b6iiq6x4FtLu/9OpyQiylcjTOLB/7dNzVCrgSherZ2jeJMuo5lyHVVF4LIPRe
	lHI0/aQidI9ACUliFKbx8gUk9w4JeAH/BBwwAJQsL8adQ==
X-Google-Smtp-Source: AGHT+IGfZ9IK7/pUtfeHc6DgLv6HZzhwz9kNk2kkDLAQy9Iwa65qh4E0Ue47kA3UHq9LU15ooN9UNEALddPaiQniOhA=
X-Received: by 2002:a17:907:3f10:b0:af6:2f1d:a73f with SMTP id
 a640c23a62f3a-b01d976e782mr648284266b.53.1756701035779; Sun, 31 Aug 2025
 21:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-9-max.kellermann@ionos.com> <202509010724.bSPPSD1X-lkp@intel.com>
In-Reply-To: <202509010724.bSPPSD1X-lkp@intel.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 06:30:24 +0200
X-Gm-Features: Ac12FXx1zNxU809yDaeQgGpOMM6Li-1LYjsJkwZ1JPL5dRiRDC0y6VWcjO3jTXw
Message-ID: <CAKPOu+_7w9kd7aOp2J2YtYMDbrV1pfrdUT-CnPmHfexGb7RScg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] arch, mm/util: add const to arch_pick_mmap_layout()
 parameter
To: kernel test robot <lkp@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 1:44=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
> All errors (new ones prefixed by >>):
>
> >> arch/sparc/kernel/sys_sparc_64.c:1:1: error: unknown type name 'ickj'
>        1 | ickj// SPDX-License-Identifier: GPL-2.0
>          | ^

Oops how did that slip in here...

