Return-Path: <linux-kernel+bounces-738775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4BB0BCE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80427174C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F5027F019;
	Mon, 21 Jul 2025 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi4QzkZl"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8022F32;
	Mon, 21 Jul 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753080284; cv=none; b=Mt5z+P6QCOo+h4VUkvTwMKqsM/X89uWeHjn613zrQ3BbU+Yh9x87vNqnmwq6UqnxWZFzzOE/C8K8PFWZaHce94KAJHXvbPKdLmTUCwlOREGyNrkPSgYkMJfFvn3XD0kpWeTMiDmJZEMihZNv+eNFfMW0UlBqBViDmKeYg+V5R5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753080284; c=relaxed/simple;
	bh=ru2N3G9QlQpKucfm/MDwmjES7XxxA8npfC7WYOfwH8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbgJYPzHUDHsS3lUF1rGfpqDh8qC821KBvVksvR9RnE6wQr+bYgQi8ag6RR2imLmLQ9vr3DM6y8MZUaLZ9mKku2m9906kyNMayoNqR8SU+gsU4x4eaJXmJA2jWfKB76s6lL6cx/Z4yZ1e3aHF+5mTdsEMrr3JKOD422Cds7Iugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi4QzkZl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b54af901bso2524391b3a.2;
        Sun, 20 Jul 2025 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753080282; x=1753685082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFzStXrIzMQ50+YWw8CsyRcUVZdk9Q6pgB4zYanj+xs=;
        b=hi4QzkZl3sw2t4EyTCdVJMSBOAWsTbAoPHxdrz9jtT7LwveUtrhzhvU51L+cQLWUiK
         +blB0I1THITE76ZDqFWYRCcMrARW+HB2zXuLzk5XHgPNconNaAqwI0CryGcV6FgiPxET
         mqYiyTgiHQ6cxWTjbXoR0nAYHw8mHfu7wljuLHX305SD//JwXXd2AP16Hx5a29yEdFW0
         WTMieiCajtOgUWJ+RwL2j2y9e9nST6iptlIapHq9jKLjAp1MCOSp0jVrrtx9lzzZZaqs
         w5T0wxRHmAi+p4e+z7Lf0ojF3Me5Y9BbcuVxuqYI74JRImDKGZGMSw24qXxH8pZ8cGJS
         Yq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753080282; x=1753685082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFzStXrIzMQ50+YWw8CsyRcUVZdk9Q6pgB4zYanj+xs=;
        b=Zzxx4yqcDwITgSstxJjJUEsutrIpEUV+2qoqCcVpuWeJ7lFQwu8ZDd873p8wPK3unN
         XoWoKG/JA65e6ohRfb+RlCp4DoPvW+Y+JbRHHiCszZRv1OSBpxgiB7vFo0i57fFTCBtl
         bFiMtuiV1jW4wyVbjA5IJptIUMGmxj2igV4MBhR4aq660VH14f6zlE36g/7curzAh2Wl
         cSpXCOtCfOhmI1geJZeIEePR870gAxEVxdFRsR+cZ1tEr94Wzpc7WvhesL9p/Jo45FPe
         SHnaqJrjV9UmXlVJ1LzQnMizr60QL11MVMAagrMQSazsEqYUOX+udTGD2MhWkB6C6zKL
         aUnw==
X-Forwarded-Encrypted: i=1; AJvYcCX6CaAL2mhOO6yqN9WwNtTODOlLIKT0iIvMPBwjhrG98sSdAkF9T9LEb4hJFJRx07ZsHgsDvE0Q/V332Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyORixrcckqBGsDaOh7ai23HiI8KvsRuggLk3vcYAkFDTzpJXa7
	s+cbmufFYC+KzDQTlPhCFH4cLvRp60NooFn2BrZZaBlMwBrzFxSQ8e4H
X-Gm-Gg: ASbGncsEQO93f7LvL72RaytCR6UoG7eTXS9yiNPBDWve4iruebZKdDP6RFmdeJyQLWe
	CZphxhjLUj0K3fZ06lc7vStzUBZcuIcohAV0wuXCh5Evja4Hb3UXjSRH0iEl2jPFGeqJeA4ET9C
	Zka8xiHTPEkGAIbO8uTMRguuSJTDsxrp1Q29zDyZi68BlqO2tD/2/ZFBiXzeh0lIf2bKT8u0cSX
	eEzhv+gbnKwT+5oZnbgFoOAWTaZEY672N/E41CufeT0mP7bisxMAXm3+kiX8haV96H1PUWmvM2W
	vU3apVJdiIHw5qCDmB1FptS//xRzwssP9UvdeKAz1zTI3xx97X1mUVr0xes5lR+j+JdNKDMq9NL
	6hlJKI8xU1g8qCQ5ThGKnIxdHQU5ynHBvrg==
X-Google-Smtp-Source: AGHT+IHjfgFkHIbFBk5iJ+h1OPVfZ2wkUNERMf2UKiPsawlLsz2eMoKf86B1NSK+GYht5Adq8pSVVQ==
X-Received: by 2002:a05:6a20:a103:b0:22d:fd6:95e0 with SMTP id adf61e73a8af0-237d66186dcmr33208437637.11.1753080282080;
        Sun, 20 Jul 2025 23:44:42 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb156a0fsm5080765b3a.98.2025.07.20.23.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 23:44:41 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: vkoul@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com,
	shuah@kernel.org,
	suresh.k.chandrappa@gmail.com,
	yung-chuan.liao@linux.intel.com
Subject: 
Date: Mon, 21 Jul 2025 12:14:31 +0530
Message-ID: <20250721064432.4043-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aH3LEmB3hafb3T8E@vaman>
References: <aH3LEmB3hafb3T8E@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject: Re: [PATCH v1] soundwire: replace scnprintf with sysfs_emit for sysfs entries

>> There is trailing whitespace error, pls run checkpatch before sending patches

Thanks for pointing that out. I’ll run checkpatch and update the patch accordingly.

>> +	return sysfs_emit_at(buf, pos, "%4x\t%4x\n", reg, value);; 

>>double colon?

Thanks for catching that. The double semicolon was unintentional — I’ll remove the extra one and send an updated patch

