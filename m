Return-Path: <linux-kernel+bounces-801820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F9B44A58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A27A01569
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578812F6565;
	Thu,  4 Sep 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OZbge5R+"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F42F656E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027932; cv=none; b=pVSFrinPedsO59lXxnGqLL9QSzJ3o4dxoFt0smgeZJCCsIVgOlOAJDxZun6882DxU6s+tPcgVeIFCEKxKP+lO1rpZCBFJFQwzCncS1kgGEuv5/J5BMI2rd7A9sNADu+WfTyuyVu5v5yUwzZwRm+Y6elZQuXdtQi9kf1uEr4y38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027932; c=relaxed/simple;
	bh=khPKfwkL8jwgF03lcfW4AnZd4LSQzunHyzh8gOCnrFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gdzS9vQIbD6XpZKQsVHMQC4DWJKxG6ji/cOLg9PgLKsRpFRhDceXBou84Y5jDr1mjO/qlreUvJczF8mpkE3y64L9pxaKWK6enWawFvTwrufhP5lutTUdFwVsmJPrG4Z52OB9ESTXiacIjoVXgO8ndKUcXfSXp3LtLMJcyPPNg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OZbge5R+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e970f3c06b5so1571724276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757027928; x=1757632728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pUUIF338HkUQ3bBfDAjTwfW1LnwUNwCLhnsG11SRTe8=;
        b=OZbge5R+TF2SmXPYSyW3vDMOafFbUGg2roq0sSehbTSkFBSsjrSALU8iA7W8fImQ9i
         5+48cbBe5JmWk+xH0xheSScjOkwWycdS+nXmlJRRz3FcLI7J0G91OGSgx2vS//RpR2+f
         MgEsIjXoPb5ngjnzIleu5JEDDVXeGSgo1wPIdAC+G3JATmBApIV6D/uAhO1Qp3S47DKl
         bLNbUe2YECzKPXJ2wI209hXZ6D8UbYvO7ISIIdnhlO2ROddU0VAfIt9QfFt/zt45Qmpu
         93RR+BOT2leTBZCVy/zcuPSDGRKkH3QzPUJlnEx1436/5vQC8NluIeOfLxo5x0tl8u2n
         rwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027928; x=1757632728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUUIF338HkUQ3bBfDAjTwfW1LnwUNwCLhnsG11SRTe8=;
        b=vwbLDMdG3X3aT3MG0/G+Xkr+kk4f3aro/w7hyhb6XYjt/LXPH+FR0Qs4sIRID9K7ZM
         nQ869UO8WT4GFKbnTd+fj152KNKwixoj8YfpYpBMi6pENftxjO5mRHK2pBQh+gbJsaUP
         TWnXmGbCQqg5iuaYKnPqef1dfkSzyJlrjxc0mHLn6k5uZpEa7K8z2s/XM4qbr5eJPipz
         8jDhjDx8pPVDL/I7BiLAyIP2hDCRDKJj78BaDDLQjDVvMhSEnnokjF9T654PzTsk8mDq
         lQjAHhZUOxl8dVSIGKASpXqHVDYGd7XrqfGgAIcScUGqrjhnDzJ4R0seeB/O8/yQ7U4N
         uL5w==
X-Forwarded-Encrypted: i=1; AJvYcCX4q7Cl3X0yj3U/a2KjxmkmnC5IxoWoPoFE43K4TvxYIEDYKoGwHhoM9XAb74IJQrPCEjTzjZfOhIGTeoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY9Q68KPXal+Q3Od2IIUZyaYNs6llkRZf69VgjWW51Yfy51KD
	l6PnFKpzzFPNouIrFW3FS0ishOzNdoVEkloL035gOzSLZbK09qtEeg5wHeT3mLWQh5o=
X-Gm-Gg: ASbGncvt5MjM3sBHVbDGXLL79uT+rH3hLnbWJacOEyfhnypYvCBWlP6mJJz3prUL0t0
	jGDapzYjPWSwN1QbmemX22s0juclbIbHnPwiXPY218jmCTlCB28brHKhOn1M8RrcmlFjDaiJFAQ
	FtTEV0t+98AO7raI3k2+ZNjfyXtAOIKZk6KfpD8ZrCMQoDW6twLPx6xZ7FC1dNGw6hg7069uCtZ
	C2+NoRl9EasgSjyf9ECAIompih2a9IcObwQFsru6Eqffzc8+MWs8wY4XNpy9hpvtlSdkkt5D4GW
	P8tdwO4BwgRx9FOtntuU3k3tJttAoU8qOrVsmIAXDc9bpZyTi769p8asOdqPINRt79Xij1l+QZI
	FwnEUlPrAUu874Xllew==
X-Google-Smtp-Source: AGHT+IGulzpcyXdUj+05OBh9jel6OhdB+LzJj0TU3mQUGlvJdwN00n3yLtqIr7KfbHpfRWnFA6FbKQ==
X-Received: by 2002:a05:690c:34c1:b0:722:68b6:4f17 with SMTP id 00721157ae682-722763357ddmr205447137b3.6.1757027928508;
        Thu, 04 Sep 2025 16:18:48 -0700 (PDT)
Received: from [10.0.3.24] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8501f54sm24998367b3.39.2025.09.04.16.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:18:47 -0700 (PDT)
Message-ID: <c40b5b7a-3a9b-4c52-bd74-02f3c3b56c87@kernel.dk>
Date: Thu, 4 Sep 2025 17:18:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_check_coalesce_buffer
To: syzbot <syzbot+3c84158e2daa468b2a3c@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68b9d130.a00a0220.eb3d.0008.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68b9d130.a00a0220.eb3d.0008.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz dup: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register

-- 
Jens Axboe


