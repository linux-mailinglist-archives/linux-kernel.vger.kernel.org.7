Return-Path: <linux-kernel+bounces-736458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398BB09D22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E2A84503
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281C9299927;
	Fri, 18 Jul 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FRZQwFmV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A729824B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825386; cv=none; b=XedTKGm0rqlRztwLOOEuzQAHs5/spAyc34yBaX4M4acm2e67yEw9nMYXeUjyDUCG6X8n0qihozzdSYbwHf9qYmf1JzesAk32jRhaGTc9yKQAqU7QxDGiCZWU8YvpU5LL2IPQWDHc2FLZ+gaLTvjJ4a67cz/NqKLhyL4mSN4J010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825386; c=relaxed/simple;
	bh=zMbY/4rJXsuMEE3kFjZ7VDvrxxIISmdTxEEeas0Ou50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taezduc1aTJ61PmEU0ci+JPe0SM48hMHya8xaWX3hqbcVNKKoXlnYnVfk6mkQtwb4Bs8+bkrnS3yU+QmwF41WEpFoNCgho02a7OQtAWVsAp04ASG7BSZg2+EyEBnXy0jUgD1Inqb4U248r5YnauRYyH4V8qFNt0G7uyFMhNLV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FRZQwFmV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so19110225e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825383; x=1753430183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcZkxfd2U5WEwXiEp/soRoPc0T9SaK7d+mV9oirE70o=;
        b=FRZQwFmVe691nwa+Q6visFMIToDyjodGF7HCRkxnuid53bH+2dSMwdXpw4kOm90OIC
         i+qyox7U/AAng0R3dMUWKmz/IoVoAvXoCGQkUXKKMBl5nYbPttHqLCjNGy+QIfN1hucK
         mT0ljqjxvAc1mv7JcJyNCzycijiz/B/jbPgVIPbJ+MblLSsp1OdTEIqfWl7IKzlZkPbl
         GF3wtpq8xFgudBanzMcw+DdXr+nRkYpHIDMytlKzZOfXo3f74A4lq61dFyLRmqt7KQ8e
         2v/ubM7tzm855rORbMzxwhJqfnd3ycnlXobEsGdOtJD1H9JeVovyLKV6BbzN8Wob3NPF
         1NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825383; x=1753430183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcZkxfd2U5WEwXiEp/soRoPc0T9SaK7d+mV9oirE70o=;
        b=C9ijtDChiZ1KdjzwVBUq9w0KFVuji6XsomYPlwTSXy3IS3ldOWeT/C5RiDfK9D/hap
         a9m8sPOTYYee+yyh6IH2Kf3c6Wy7muEITiVrtN4G2TT+2RVlWmMCrZhrxM5AnLty8brK
         UJ+Hzw97fo9TCbdbd++fEBYVold6T5UmKigi1PQm6odp866qLTUBXJCFS/9pc4/PgVHk
         1f8LJiJFXwY/tR/LczyZXn+b1qkwgeBWJLCTBH1oiA9fnwVKuxaBiitl4vwhQCcYeLJo
         StYDHztcGFQfEBDgJ0ta6woPGtVkcAiZbpDEuRSjc/PJTwMTbc8p5jAnV8bEJW0IZIx2
         YYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUwRySlhULAdeZukiWMgL2ZvxmPZuhtgwQ6MbmlgpH2g0cJzD39Jm92onl31NwXk1S0/FX4xu31WXHU4Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1upj4mKXo7IiHL2W0C6pvav9T70DjiXIe6YfZcQM6CyV3HJB
	BwFtcMZ2Lmhoq4VofMpJU6Pl4kDRq0vkYYDlsjzzVaj+YtR0d14+XUvigtg3z7i8DJA=
X-Gm-Gg: ASbGncut0xDfmq5alYmoJxgdLnfGeGazVCMQDy4AFhv4T1eVPfUlOwkTuZRWs2n2njV
	bGPwDheoTWVgKbIh+nL4+xqE2wcXuwk+EwLJcumd2efF/jSCfAUfhbF4bzfDbDSvGZEQAC/Jw4X
	ZuY8uAvGgv/ZzUoz4XVLJt+vGfoJCfpKL5btHol1ZHg65UqglcOtoDKTe/0eU2i0HL8hTf4xIEr
	gTnHtUoDipoAba1ZDr26Vp/WqrDySDWtXEJEkLZlG8suvgVJ6YlmQtB49qs4OW2IMu8f7UYP2yp
	NvCa83rwBxRwvnDs3P3g3s4nZgLkIltXtRClJ4QCM20y45jXqo9UsgeRmP5I3XAALfWI8GrKFPX
	no5zXZ9tgYK7Ve4SPcOgp
X-Google-Smtp-Source: AGHT+IH0ZVDunuPVsLmlomPhf934rkbSLTvHuM7DA2zkOmV0L8pCs/4DtRGF8zRJ5WSRJaMBva+POQ==
X-Received: by 2002:a5d:584d:0:b0:3a6:f328:22b9 with SMTP id ffacd0b85a97d-3b60e53ed43mr8051499f8f.51.1752825383271;
        Fri, 18 Jul 2025 00:56:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Guinot <simon.guinot@sequanux.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert lacie,netxbig-gpio-ext to DT schema
Date: Fri, 18 Jul 2025 09:55:53 +0200
Message-ID: <175282531511.45055.9031498338657756750.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202801.3010442-1-robh@kernel.org>
References: <20250714202801.3010442-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:00 -0500, Rob Herring (Arm) wrote:
> Convert the Lacie NetxBig GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert lacie,netxbig-gpio-ext to DT schema
      https://git.kernel.org/brgl/linux/c/2ae9b28947d486b7980b990cba205b1862b6d7a8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

