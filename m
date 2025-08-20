Return-Path: <linux-kernel+bounces-778414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9055BB2E566
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3022F1C846BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6262820AC;
	Wed, 20 Aug 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgb+8r62"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA228000A;
	Wed, 20 Aug 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716407; cv=none; b=hn71lOJsMacC3WYOUXUeWkk+wK/TQfJtqj0/wdNKhbToHs72NNEjCLLmaxOYZfbs6ZYyJ9Je21OKZP91p4iHyyeEACj76t04R1uqeqF55bTn6Ir/qoLRAtEOAH/A1VBL90OUq+2Sf3EU6RY8e9+tN1NhLuRGZ/XiRdwJrw6+WD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716407; c=relaxed/simple;
	bh=CrznjweAHSf23akRjxTFtNg5TyltX7+f+/5p5bUoEow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I88Az1PYjOSkI9j6WMrUjN4T0QLLnQAJswFY6WyAoPyda5RYQ7H9g+LHbkHAyCTG2E1qaJIzHmyeb7Ahpf8BleH7bvoybRJvw7EkQHIgX9i6v68bOJK+bVaU9wcKN9CLiVGaEkl7k/S50RtAvZ794s4dZVZrFrz4TGd8jKCudsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgb+8r62; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e202e0so256822a91.2;
        Wed, 20 Aug 2025 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755716403; x=1756321203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrznjweAHSf23akRjxTFtNg5TyltX7+f+/5p5bUoEow=;
        b=kgb+8r62C0dwY4kBH/NfpBDNDy1HOYPA6lhwQ6VVAc0rXfOlLFEPWKD0OFm6aoLT9J
         ZkoUzV7gxmCtw1hdm4EnoqR1elfR8IJqR1NJmi1J/q3axLMYZy9Fc3kpPZA+7OEo2tjA
         2NGBxgAFxm1j8JWO04a9fxXNxmGmq1+E+ktiGgC2MgbWTG1EEEP41I+YWbnOpBS0ORvn
         3ffERNh0qPtQbPVTacLO64TrO+fdoy1aLbjNsnJxyVRvB4xvqGwMHLgAx/XSv8Q3QqZh
         8z5Nq4LFyrgAXDuGiMGj+58yeUxTwj/M9pYCejEQDxiJkkmf3RtUzYbZE60u3I3zsLpN
         4Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755716403; x=1756321203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrznjweAHSf23akRjxTFtNg5TyltX7+f+/5p5bUoEow=;
        b=B6rIz+00f0V6470xksSiZ0SCOpQB6m4Vz+bhEZXgUY4jLFIDCkqRrVFaZX74sZ+OtO
         /OcWXgsZBiz0P6Le25ai7EwU/8aMKHyMScR4wvTWjhPwryDaSXzmsA5Rj5zS24RG5G0P
         4d5SUA7TftoAue8/Vl4mtY+ik7Psus9lIcSV/YSwu1isaiRGJNL7WUkp/dPVoq1lKpn0
         86eaOOztUl6LOW6tKHG9+A1nKALgSZ+MWO5h8bLz3uTlPlek0R1Sa3MtL30QrRl5KyPk
         SxLktF95c5OY9+4gCQOrE5rp8t6rZoZvS+wnCGou3b4j7XPo9qEVqA9QwCgbFWLdfGoK
         R03A==
X-Forwarded-Encrypted: i=1; AJvYcCU3thVpht1gCro/Y5kdUSItxtYQKRy2xh78wqEAg1TmSscV49YCs2Z2e14/BO/yZksJzTfr4JofTSA=@vger.kernel.org, AJvYcCUVOgvJwQcLlm10EUSHE3pIPKpUNt+xoKel8T9EroGKbWnlFKz3YW8cqUOntdVsnAUPJzNyTWwZYKgxVbr7@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxWQn098Fbbbc+S6O/lTqAHMfb6K9rsD/k5BIBhyvpjJYzEJA
	Sq3vOjMmbg1BqWzqr0km2/+cLTqd1BH0WhXFFQApJUS6vc5VXbenZkRAFiYG8Ngxb9E=
X-Gm-Gg: ASbGncuXNLfzvVuBtsevV75oMVHiXSZBmwM5LUgROFCBzxiittfG9i8Gvggt/VqWmcI
	jiFqpcscxCAkOzldjZcnNuzL3Dm/9QAJ1xIfiQ6W+tHLzTE8Jplug5V+8dGH81XwYrV/R9d7J0X
	mIlMBxR7zRdCXwQHF1Z+nnXejdgoIw0x0nCFbJBmtAk9Pq6IdgDxjByUNLk9z3Wb43dB/LQSycS
	jk5M69rTosvkbyTignix3/gzdYENdgMl87BzP9CiFe1Q9ZJcQi5Y7xzB3zH5EjObtuGe7PeXPpB
	59fQpezhYY1nxuBzKa2TsIGZ9bcNBOY5kvYCakqPNWDmsyDvs8K5o15T8BiySepHCb3PDMHP7ow
	ZbvPn62fcw/o8GL/N8pXF+VNRne4=
X-Google-Smtp-Source: AGHT+IHIKPBZDKT7w7IpWopx5uH4BHntATqlKUcI2/L3Cr9WY9dhlh8vnxgsPvJdCqu2ZnTQWYHb9Q==
X-Received: by 2002:a17:90b:3b48:b0:323:264f:bc42 with SMTP id 98e67ed59e1d1-324e128ea93mr4998711a91.3.1755716402534;
        Wed, 20 Aug 2025 12:00:02 -0700 (PDT)
Received: from lkmp.. ([49.37.163.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f780bsm6089677b3a.71.2025.08.20.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:00:02 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: rdunlap@infradead.org
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	rakuram.e96@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	skhan@linuxfoundation.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] docs: gpu: Fix spelling mistakes
Date: Thu, 21 Aug 2025 00:29:01 +0530
Message-ID: <20250820185948.18805-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1fc93d62-eb77-46a6-964f-c0bc7348d482@infradead.org>
References: <1fc93d62-eb77-46a6-964f-c0bc7348d482@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for catching that. I’ll send a v2 with this fix,
including "fourth" -> "third" as suggested.

Thanks,
Rakuram

