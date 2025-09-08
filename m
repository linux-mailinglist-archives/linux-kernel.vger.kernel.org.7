Return-Path: <linux-kernel+bounces-805675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFD4B48C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C733B82C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862119343B;
	Mon,  8 Sep 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF2t+nxX"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638693C0C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331046; cv=none; b=T4P35VXedvArP6p3X2QfvRRmEKBfPTdK+rTZqcop4h643Pj0v1yDPk8/ZSCC+2d1x9Kcncxd0wOQTv23UGMz9GsllVm3Oc42vtAFwZ86lDEPTGp9rKG/uEOQJgUgQdg9xlknYRkfQJAE4TetyfNF3uw/XrGJ+iTGNNU0mXhoOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331046; c=relaxed/simple;
	bh=Sj8wR8loCfL+BL8BD9MhAr7hzFXWSWyg2zKZVcz1Tcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTI0M05hthWqn/sYvB12GGAZ6VlVIXxTwuSJmVyvH+hB85+VW4VGHi+qPJ+uwuRWx8tTtG3dnEgxFSdz1sbFUMCVCUVbrmItoUqQEZcwKogJE3Sn3R7Dz8lW6SQIs+9lQTytnPeHqmRbPzdqZYzz0LqpL4e1nMf4MpAIeBMMUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF2t+nxX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so28266825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757331043; x=1757935843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj8wR8loCfL+BL8BD9MhAr7hzFXWSWyg2zKZVcz1Tcw=;
        b=mF2t+nxXwUqEm6x2UIBRhubts9FA53JdiJX9HIIQXNid6zDRXFrWjnmfrxc/lpZTF4
         +WQRtpsYdBfbGA4STOhtJx2PAQUcRrrIZ4TTKS6UbLTKH0ONBDIBFuq7oJSoEXcnIKEh
         zo+VGna1ewQnHt1xa1VKB+YAnFj0ucS+63Ptw5hVdXoqSUSVLm9kpgCPiwnexVEyHZfF
         mj5gtZxwUI5QOMW4geasfiK2IM8C4hEsJkMooFtCzEuAjKle64txnbro7xjVsxZ9oE+V
         HazD0Omq39y6GVU5KFceiBMV28KEPCwAK44AHgQqbLBVYJbwBfvfKMH61SNPx8AOlH3r
         sLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331043; x=1757935843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj8wR8loCfL+BL8BD9MhAr7hzFXWSWyg2zKZVcz1Tcw=;
        b=UWGp7JTDauxpL3X5WLf0nyV5PUZ9DDsVYaZFfnRUPW/cpuLgMTEHa4iFV4RyyWyNT6
         A8NrbvUfzYNznY6/E6oeHYF5wy+v06wBpUelG5Lgmax8NUUwL8QvWzjLHtst8Ewb+snC
         r9u0BnvudPT9tuVd38SDzOcvOXHTOSUcYGw/Qsv/4bqKsEhF8r9guXWsgJuYYTq2dIse
         LF/UeT7nhN8W28luziFlpUirFnYDTQf2UpUUxEW8GFSnC70rXW67gNIgt5h5b6ZI5IKJ
         weQCpgcR3z1uXFxNQgClqwRL8ZUX8yYlViuA0cyKKUBHUawoGDXA6KQVifgjF1kMVi38
         whmA==
X-Forwarded-Encrypted: i=1; AJvYcCXfozxNXETNGlraParSdTME6c8GeRCFdXjZDbOnhhIhvc9+qFhK0BUL0Zlea991g1DyRhsupa1wNC6k2rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5aE+B04dxb4rjaCG1aZEXieW2dfJQPygCMv6YYSMVqHb8IKT
	idIc+ykRGB5SeRjMzqfRDjKN1M+9NVSts8l/4JqeUAs2qDM+HNsKmkMj
X-Gm-Gg: ASbGncswF07wL9udT7WarCvng4e1RFva4nHzrX+plZfCunoqZvRC2d24+erfXHFSXTJ
	cpUTZ6H2xHn+/i44hLq4y3OJCyd2rjp2X5w2fmqYOvjFoe79ErwFWs9TdBxkgeNH4tJul0t1Z6q
	cEGFvm6QRc+IAMQXFfPldJua6FPoZ2fi3DT0BtgLz3O/LvkuSS3KnbMoaHCGPC22CUO/G0QDIWb
	b9p+wOYrRbMziakVLzTzxCx02LU0TgaU5DH5m/4webmIa5fp22/TXDG6QImxutRemLXpM6/ljzP
	wlPnIFRRtMD15Xzsn1mK3moEtAH87qDowO191V5thyIPtE0j//7MonnbphoOBsm2pjyj5wbfFYr
	EvrgfEz4uDYCChuptL6oC3M+sO/fy/iSGt6RVLVw3tAnMjtenzkzOfcvhjDgffp2qCsdwnqOBTg
	EUw3vm/PJ720g5zzb0HvaYFxW1BWToQt3vvf5qxEOIjS5YEdaGog==
X-Google-Smtp-Source: AGHT+IEZdRqdKNRzQ4aKulSAXapzR+SOfXlwIt3eDMJ2N5BvZ9uT+IJmtyIpieQvOG69VDCQJ1Rvmw==
X-Received: by 2002:a05:6000:1a8d:b0:3e4:5717:3684 with SMTP id ffacd0b85a97d-3e6462581a2mr6930466f8f.40.1757331042368;
        Mon, 08 Sep 2025 04:30:42 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de45dce11sm61430105e9.10.2025.09.08.04.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:30:41 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Leander Kieweg <kieweg.leander@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tiny/bochs: Convert dev_err() to drm_err()
Date: Mon,  8 Sep 2025 13:29:15 +0200
Message-ID: <20250908112926.41182-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818113530.187440-1-kieweg.leander@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this patch.

Is this change still of interest? I'm happy to make any changes or
rebase if needed.

Thanks,
Leander Kieweg

