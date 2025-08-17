Return-Path: <linux-kernel+bounces-772662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63EB295C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7EA1655DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622D79CF;
	Mon, 18 Aug 2025 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8R9lLLW"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553244C6E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755475260; cv=none; b=JV/xwhP6xL8+dK5teisJrVcxXiafFT67LipZ/6oK6o5WzQykPYo8OgbGja2ezLOsDreuE8b8OIHNlNYZR1ClG7AdxbOgxwe6Lo2XsAuX3IrzH8r1/NMd+4OeKL7eryg2GnqxI7ZQw7JeOKZsCqe7eC3jr+Jluib8xvZUV+bTadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755475260; c=relaxed/simple;
	bh=m1/hI4zAQpa/yacZ07Q91nQ7zDbp9gtYAaNYK2UtTyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKIIdC9PTSvorR4HnK3JyGBFS/86lecp9O5hXk7pHuUzrmZRcbMMsyat4SzJDM9uXNekvOdxJyWOOyoFYcmOCCEKZ5jOpWoCRVAVS8IWzXNEiGAFaTtIcZ3fRc7KDQjEuMqZGSqLD52u9lcQ5Y322+HOaqHHW1t7VLRN6eNjymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8R9lLLW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e4148134so1712445f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755475258; x=1756080058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1/hI4zAQpa/yacZ07Q91nQ7zDbp9gtYAaNYK2UtTyI=;
        b=W8R9lLLWMoRq7iORYGBR1Ma9hukOkGoDA8HGQaY9Dx6gfsc9kZO2z35PbXo1+D4XUF
         Ci4sZtFejNnZPG4pjy65aMxRvi6G6A0JEDtlTLHbqe3Qbh4zYexiYs+xshnWWGDRbZdC
         SbVGDXA8DO4PdYT7aPUDGGOLW6WidIOC95QmEKK2egtVSyDrMpSlex0yhb2RrctqxiSQ
         4heC2Pllx4g1VbkQz7JL1K/+3u4TU8zgbpvkkHOu43paObBBJxlHGstbk4hCx1dG4McP
         NjqCVNHDH082Wj0GRF/+ALkvCFd9DZN8RtmkdSxfOc1p2tf73i576K4+JKdlMfKo76Rc
         FsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755475258; x=1756080058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1/hI4zAQpa/yacZ07Q91nQ7zDbp9gtYAaNYK2UtTyI=;
        b=qYY/3JLtbL8yXHU6O3ZH8ryftiy8iinatfKgmTe+JxLZILGgKxUTcD5TI6ns8TL2uo
         Jj7tZm15siO5P6xnxiT5MGX2ITGrSb1W9g9+BhgT8NXYYXawCIrr8m/MGckkxWroPnZ0
         d7sMNEH4B2Va4yX8uC91H/TCejtEmx/9zyTF+w+SRUQjSyuVB35sq6SM39ZB3Gxb5zUg
         YhJQ9/vUAyrRR+5GJa4aG1l0BFyKnWhyNWezPcOR2oEhshkOx+ZSp9Bl+fpFpiRz/oTc
         AslnmN9dqmUEt9xgKjALUHmOKcNY+Ilwc5qnMguH3cx9BJCWYCuDrMptXdxqiXOhzuO/
         esFA==
X-Forwarded-Encrypted: i=1; AJvYcCXFZ2q8FFFtVW62BvdHjN32mRdMIYYuaVtqh2YUqh0D/3BTps+DCOEFnWRFurm+SuaF5YC7yJyKYvQwj60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLaOm3BJsGDJGB1unO6iLNBaqjjRZhsLPLyHbFUe/kg5zFBEG
	BtyTu9l4B1Jbd+U1SbSHuALEPvw91wksh7HCl0qX2pHVb6QNCS4EE+wg
X-Gm-Gg: ASbGncuCFWYK+5arRgPPH1SlhJwlZz7UrOKK8d82fkkYo3d12fImj1bLX0j4WFq4vrN
	XPXm5iYt/O304SinbGEHDZAo5g5QSyp7g4ZTBjESNIw47GvK/EXHYRo4geSbUSBhCVAVyLP8nVs
	mtTzsykhZTeqCGu5MXelz3UBd0niNLEcot668GTp9wLwnMlSVBidlt6U/cBa981lqN0h0N+7NCX
	+QzLipX3uEw7+I3SWOCeTvOv9Ic34YvYacovMxOa2gN8X7XuOOd9kOtcsyKnEj7u5J7UF4OYOx6
	A1DUhwtaIM1SJT8YXJZ+p3NYQBaPdNjNe6clHu4y1CghgczBZrmFKSMR8OETGJJa+duFsbosPrq
	OthwvxjXVlIFFXyNUTvcoOhi4JFWvyBNbZujR6lV65MRVAfda/nGzRw==
X-Google-Smtp-Source: AGHT+IEAB+WLlffq7V8E4TMyf2eXBnLp5sNhzDD2NavmOoKq7fhLVZX5GaQCOGPobQS9T6QuJHPudA==
X-Received: by 2002:a05:6000:18a5:b0:3b9:10ee:6e9a with SMTP id ffacd0b85a97d-3bb6864061dmr5979713f8f.33.1755475257446;
        Sun, 17 Aug 2025 17:00:57 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676caf79sm10734359f8f.42.2025.08.17.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:00:56 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: "[Leander Kieweg]" <kieweg.leander@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Sean Paul <seanpaul@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC] Plan to convert drm/tiny/bochs to drm_* logging
Date: Mon, 18 Aug 2025 01:57:48 +0200
Message-ID: <20250817235836.134286-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: [Leander Kieweg] <kieweg.leander@gmail.com>

Hello,

I am a new contributor looking to get started with kernel development. I found the "Convert logging to drm_* functions" task on the gpu/todo.html list.
The task description advises contacting the relevant maintainers before starting the work to ensure a patch would be welcome.
After setting up a build and test environment, I've identified the drm/tiny/bochs driver as a good, self-contained candidate for this conversion.
Would a patch to convert the remaining legacy logging calls in this driver to their modern drm_* equivalents be welcome?
Thank you for your time,

Leander Kieweg

