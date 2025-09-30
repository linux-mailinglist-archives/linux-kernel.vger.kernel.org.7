Return-Path: <linux-kernel+bounces-837043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3BBBAB270
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1391C4A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC68228CBC;
	Tue, 30 Sep 2025 03:27:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C913777E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202852; cv=none; b=Ie+j7i1mn+8yWywkS/mlLZLd1mqWcx0+9akMUkqILT6GTxWN9hWhBV73hRi1wcsKyvdikUsz4e9WWGAh+WgseCFRTPple2bJjQQF8sbFl1lYKdqslfiI07LCewc9T4ngFq6MLXDD5jZDPbqxZlWd0b/Hl5hY3vijkWGma+6z6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202852; c=relaxed/simple;
	bh=PQSBg812Yx1yXTtxwQuWqKA6s47bl8Wen48AF09fm2o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nl0z1+g6PW9uhku2cwHaK6jEf2auYU6EUPoe1GtgC2SlVR0hMR2mPPVHz1066m1+AQcMkOT5oysrJMZ/e2EbouWlU8WIS7F9yAGdJQaM35h7yCenW7SnP6W6JTzEiPcMi8UM3Fn9HRfSnQnnr/Vzw170WAnldv+G9s/a+xKnlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-927f4207211so205723939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202850; x=1759807650;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQSBg812Yx1yXTtxwQuWqKA6s47bl8Wen48AF09fm2o=;
        b=g9Uuancbmh/x8KFmjEn6vGdahuucEh1WK5sG6phDyNe2NSyTLH0SwZ4wGKDCVYmDoK
         zpRFdibK36cG6PD2mK2JQ9T2fHyGjk3pEPZNIO5cZAgPeOP2oRb4tYoQtJgaVQtODGFi
         C+B6+juyDqJdxMz8bfX7XRbOx+DJvr6zp2EBLiwUj9ypl0kU1baSIkIY+PvXVuVdA0m/
         rFya80+repzwN/sVurLVCEAj8YPQ1ZdpD9Sp9reFAkEPFugvrJEcl6uJhCg1bsUI1V9Y
         WbvPlwHH/ZL3qTteXvMVH2DcGo8rYFFR3Z3qJ+pEG3yIaOggmWjv+xhBbBwLlND/Elhl
         txXw==
X-Gm-Message-State: AOJu0YzZ1Tv8y9KQ/u5eE2PxD1eeAd1Qzef0z5o8R7z+rxMczk87SgcH
	b4TjMzOVPGzZD7OsK2ZiREXBjxUIFjSlpnRcXwLnTHXrXeFx11Z1nFc4hGj2o4gpl3BhiQjWiT7
	8hExE8cMYEv369KIOsXuIj5Vjvtp0bQ27bITGOHzx+RsdV7ThRb/ewcyTFgw=
X-Google-Smtp-Source: AGHT+IHffwbbYHe5jEqnFDxVFZ19pPUc/2LtdPPbMun4qoaOiuKF/NNjN33inzLNotXquAJdB9uP6CZClwlF0gNu97lIdy0cVz8h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14ce:b0:928:69e6:296 with SMTP id
 ca18e2360f4ac-92869e602f9mr951635039f.14.1759202850630; Mon, 29 Sep 2025
 20:27:30 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:27:30 -0700
In-Reply-To: <00000000000094071d061e9d0f66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db4e22.a70a0220.10c4b.00e5.GAE@google.com>
Subject: Forwarded: WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in drm_wait_one_vblank (2)
Author: chintanlike@gmail.com

#syz test

