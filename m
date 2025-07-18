Return-Path: <linux-kernel+bounces-736456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB743B09D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5614A83501
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDE2980A4;
	Fri, 18 Jul 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hTzADhy9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B329552A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825383; cv=none; b=ZEIa631JhXcf3siw7zjEGCYt90WEXWO6Wh2WA+L26HHYQXFGMruI8EoKZPytVVubYLVnLyRxoPA62P6zywhDQFDphIhs+xs3UCQwl8VO33pGNgkDniGIzoipvTzw3UmMMgbooGmribJUa4q0wWf4Jhib9kke9dpICcpi64V9Wpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825383; c=relaxed/simple;
	bh=M0ivYTHfNKMo5EKL/SFE42AtTBisBwLKEVjUSgR3mjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Olaa0NY7iVH0RO6J568BMIEtiHfYrCjqaGTruJ5gcQ4ubapRlr1eR4aLHorcsDCx+pL+Qud+lrNLiO3rccVsfoQfsLYWAe+J5XTUpFOYRvrDLAft0YBoCNPpqve3rl016zBTJMOy0ugpnEOtE0eAG4h3U7o+y4nnatbofgTIv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hTzADhy9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1513734f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825380; x=1753430180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tByAdvGoVRcpXNZHqrPSEsDcA71Dy51Yrer9MDVzBaI=;
        b=hTzADhy9s6EGmpxJcZGUhRjMNky8lYdjWma30KfFYsuANhmtffi4CDbA0pUnU7ASqN
         LFGq0SP6zV/mWEvvVv5vmb4lruqxqtYi8qgd40UdwY5AQyppSzknh/JSIoRsz0gjBO7f
         W1/ukRPdSSTqB95prUpnTXN1xdNiMrVBZnG4jVfSxrPedj+ZzBVweTd9AHr7v2yrCtRh
         yE8uMVwqNpojQQp6k+3SX/zDZuUNvNhNZFKxLwRt9vYwxwmjEdi4m7Gze3uj+uBQ+Da/
         9cVyOwKeDEhb5oyHIIXfMiCjjoXtO4TR/jrs85as2GFQG77D7HFvIVjTA3u3J0Ap6mU2
         4IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825380; x=1753430180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tByAdvGoVRcpXNZHqrPSEsDcA71Dy51Yrer9MDVzBaI=;
        b=HrXfHq+5tVtoPzfpvbP8z5GW2nernccK5Lyihj8OL5HiSuFqS/cTfo+EofENNiaxP1
         QwNlD7Hun/dnkEvgiuk1+9hwh3PnfFDYKyEZFx+EhOB63lZFcu7+WAios3y/2L5kK9p5
         Gyy/8KVbTryzvNeUs9Wl/N1hxCkiHEuCcv1bJ/tD2RdnQivxPy8LAAXbeOVRMyhy1sl+
         L+Bo5sdWdGRgIaZnJtpDg+9ehLIMBc5yMIdlQcwwvO8XQKMZZh7GOmRFhfgP53vVaAsd
         du6while1UgJlka1ibc0NcoNf+WMqCGy+Ktol1tZHUlxpcrMulse/JoiI7g88ml5w7O5
         fmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUla+PPgrpDxIGT/8eARjWY/0ja+/z7uW/zRv9ySFmYR+iZEyExdcsff4+lNu67FXqdtjG/KMQY2SiJwoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uTnSuXhLwaiVnceXeUlzO5lOqCUwsR6Ul3vzrSMZztHKwQFH
	nnbd2KrhuUMcQyt1D83mMhXBTuMIpmID0Aj0KtSVUMRMXf3ES3MSfAcRyH0XyvehOEw=
X-Gm-Gg: ASbGncuhAPT/EavPpuy/WzHMX2dl91vKjPxrOS4KeLfW72Wg0xjKRNCHYSIZN+3yEbP
	k+qLyHIXuVH1E26Gqtv0xkO+x1Oqy3F4E3ZHOdBfd25PqaR2KEetrPil+mdX78ezNZ7XU+8XT7s
	PCplccItBXu0S0pqX1RF9IiZQv/L7wlBuC0zmBLVqVecFfNpmmXTPdCaMToOmCZJh0ptt3b4qvA
	TEaZPKSEcp4rFpI+7AAqWOL5znmzrQ4jjZKt0Ij8AnP9Rr4zi7VNyFTYwmRp2d99PZ081nfyDlG
	9YcrWcsUprZZwQSNtbP6q+wNEXwedlMaIHTnW0BKV9oBRksoFQ6NoF2/u9iIxb1yCQ158UJXlIv
	g9xF1kfzx86Td36tXKEVz
X-Google-Smtp-Source: AGHT+IHlZME18JirURUd/kTyb/Qu/NZmdGhMoYIX8OZrVO5iv6nKOsk+fhyrnNFUzOH3CNN82sVzcg==
X-Received: by 2002:a05:6000:20c8:b0:3b5:f6f9:e803 with SMTP id ffacd0b85a97d-3b619cc1674mr1424473f8f.14.1752825380532;
        Fri, 18 Jul 2025 00:56:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert cirrus,clps711x-mctrl-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:51 +0200
Message-ID: <175282531512.45055.11982677771672772897.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202919.3012764-1-robh@kernel.org>
References: <20250714202919.3012764-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:29:17 -0500, Rob Herring (Arm) wrote:
> Convert the cirrus,clps711x-mctrl-gpio binding to DT schema format.
> Add the missing "gpio,syscon-dev" phandle property.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert cirrus,clps711x-mctrl-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/7aee14a170a07bf6481f65e6a36a835e6414917e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

