Return-Path: <linux-kernel+bounces-756186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60752B1B108
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B50216EC81
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAC25A2D2;
	Tue,  5 Aug 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPJBcL5A"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A09251799
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386149; cv=none; b=YfuD18r4cA+b84xQn2z55vGDX0juqM3Z0IBFC/pmccduee/jN4G8OBn4y9HzyY7eulazw56Dd1z0cjF72xe+1w9E+HEzOc5WFEArWJ6AtASE/rcB4jzNG6L4jIJe7U+S8gjeKGuUskrOZuiptinPLsWn6Qv0uCP+BTdf78a9cK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386149; c=relaxed/simple;
	bh=Nu/yo03bxwSukuvoXb5drj/qxdTuJgGHnF93xhQ2c5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=getE212FFywPkW84yhwJY34qmfvtrgg6ZioUb43S2vUIO1fCJF+phNdtqBZlclYk2NzhhCd8NWuZPzH6nhmPx8lT9wgmC0drUH5LbmHq/1qhxUKbNuGnEMqQqvrpQkBNXIeJp805w+potkas/pF6JHDepMPeJKrzU5+yI4N9Y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPJBcL5A; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b792b0b829so4156734f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754386146; x=1754990946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UF5Zt9voQATioY9RRbmU98WhyD6EdNV9XLQAXiUOGfY=;
        b=hPJBcL5AcZ+KxOtM6+HrkeUPZcSRD5dWCApPCvP5moScUD8SP4XuMoJcWs3GCLsAAs
         xxMZPNQuVDQbW+xOiOWElJJsD6gt8S+aNybf09SxI9CYMyI3+J/4X7N/Ji/h+2d0th5V
         d9ktQbFf5LQNzr+EaXhMSgfTbb2rfNI5LvSAKC5J4e3gNfKo0k9MIZ0/W5KypABb2s33
         YbjG6bByWzlV4oUsklP8GI1qN9sGLi8x3sjKcpJv1bIMRL1OSB8oYOi59yVCs2JJAwLu
         /zvdySkSPDGgacdllL2J5Gpry/44y1lXxh8otx/5TgUN1wYy5phQIDdjcJ2+/jjbquAf
         ilXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386146; x=1754990946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF5Zt9voQATioY9RRbmU98WhyD6EdNV9XLQAXiUOGfY=;
        b=WcX1rP/hrexxRBBmMeQJruykiX0pwfClyT3xRKb8txzvjZjIcua1rBA4g/j/dm3T5T
         gqbIlpRW9pnTbzOl3g0NsADhLSVhidR7tJRS5WvAjwSd+Ok5HstEmWwIBpFkzydQyOIV
         k8m98CDp9pDTtk4qI7mqFmsNXJIj7Im+GCLMvwXpmPMvoweB4BmEixANEVJleW6eqWMu
         gG+7ag1eiNA2ATNqQxexWJpQww2YTALfYRD0Lt6NkO7VQ/0HGuotO6k+9FrXzJYzxQoC
         jm6jZ6BI3ZZLhIlM5DISvCzioPx9voXIJJXBFZT0Q1NSnfJHGlG2lIJyjNL6BjeQbQzV
         l88w==
X-Forwarded-Encrypted: i=1; AJvYcCVf5GY7arEcmJ1kjmV7xhutXGnYw5YiCh3weN7bRoBw8psjecUCNq7NB6IRn47nGxnkeXRc+l4Q3rpZhn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHcSag0DtCrM/XGjQR43S+SDzuqdzyUTmnPenVhT38Iq5vxqW
	ow1Cn/gy+RwRFEgfLwWatVZOBVZ9FB42QChe4ovFChVutZihN4bSvh8cV+6SBqVmuuY=
X-Gm-Gg: ASbGncvj7S6VvqyT35bquWqtbS/qYA2DnyWyOMn6I2iPEAG+d2rf5uEXwHuViAOM5+Y
	Web1t3ObV9y11wrfCHPPbG7pv7mHDj7XWahgv61X8+GrLdZOqzdp9lrAMAjXiqn05gNOz778eiS
	aBXHeKgopTt0PFSSe49na5RI0gEcU3IqBQAN/dtgrTz2CSCCgy7eG01Et4ypRvyPkzrSlS6hpDi
	rlDIpzoo/793gDaOUXsnDMtxLH6ui2nzGGyJHdEA3Zoz5aUg9HzkIAbrnPVUlltslCr1y8iF9Tg
	5At6c7+o6LwSZLh/kPuVZwa1IFMsb67U0KZrWs7oyUqrfTfqymIwafbHav9TatmX819IHbWCvN5
	VfC+tYencnC/i72KhQfAYtakCmAg=
X-Google-Smtp-Source: AGHT+IG+S8EHXkDixCfKjiD9TLmPOVJSu9nB/gnFswyFBWmlaqpq9SDKhuT/ueldL0WcRP6mU/8Ixw==
X-Received: by 2002:a5d:5d0e:0:b0:3b7:9350:44d4 with SMTP id ffacd0b85a97d-3b8d946b3d7mr10399692f8f.11.1754386146140;
        Tue, 05 Aug 2025 02:29:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c47ae8esm18309695f8f.61.2025.08.05.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:29:05 -0700 (PDT)
Date: Tue, 5 Aug 2025 12:29:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Val Packett <val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: mdt_loader: Allow empty section headers in
 mdt_header_valid()
Message-ID: <5d392867c81da4b667f61430d3aa7065f61b7096.1754385120.git.dan.carpenter@linaro.org>
References: <cover.1754385120.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754385120.git.dan.carpenter@linaro.org>

The mdt_header_valid() function checks all the members for the elf
header to ensure that reading the firmware doesn't lead to a buffer
overflow or an integer overflow.  However it has a bug, in that it
doesn't allow for firmware with no section headers and this prevents
the firmware from loading.

I know from bug reports that there are firmwares which have zero
section headers, but the same logic applies to program headers.  An
empty program header won't lead to a buffer overflow so it's safe to
allow it.

Fixes: 9f35ab0e53cc ("soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()")
Cc: stable@vger.kernel.org
Reported-by: Val Packett <val@packett.cool>
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0ca268bdf1f8..d91c5cb325e3 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -32,14 +32,14 @@ static bool mdt_header_valid(const struct firmware *fw)
 	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
 		return false;
 
-	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
+	if (ehdr->e_phentsize && ehdr->e_phentsize != sizeof(struct elf32_phdr))
 		return false;
 
 	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+	if (ehdr->e_shentsize && ehdr->e_shentsize != sizeof(struct elf32_shdr))
 		return false;
 
 	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
-- 
2.47.2


