Return-Path: <linux-kernel+bounces-876822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7409C1C9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2BC587D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F964347FF5;
	Wed, 29 Oct 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPeqo9/A"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB43350297
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758833; cv=none; b=USFGexs+c/A2kZfBPJQ8efyLy/IjPlLe4GVUim8Mvop8cbagkaxgcNeuCYHEMSy6oHzDew47x6N4i3lESU11+ViE4Cyd6rwYMMdzDQT13adB4Hybhawx6kgb9Gs173xftopJ8uLG+2DZ2rc51K97SQz3Ep19CwRvu4YWDNgcgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758833; c=relaxed/simple;
	bh=ublZXiwdKoY00f9XPGws+wBdMsEf+N9ZiS2fyMTJqV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4XLhSkI8TwBK4Wfd4kMnxs55r8hW+I0uFtuEgSe3Q3bSIDOXKZkV0HFLaf2YOMKnDoZxRhk5PvYcm8bhCKzTVpc+sc+1Gwm9faUGjcxzsBbmOmHXXD96hnzgcp/1Qm81sU73ErTlU+twTZyg2XsOsgdrI1K3iTjZoxs+448tzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPeqo9/A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42966ce6dbdso84620f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761758830; x=1762363630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ia7dy7OugzoaAdNmxRXs6VrxDzNCl9Ybf9VuqbvbOU=;
        b=PPeqo9/ApuJLe54IwDv2W/cmnB9hjjtLv7IDp2MlxOIUkW4kTaZ65jhy7yROVGib3I
         FkBxYQzOIvcz5VrwK3x055m+DOXkus9ZO+XvkABJZsKEkyHuELxKWdPuXKa8gmzNCnFg
         QIDOsFJj30K8mxodouBhGoVGfmocPwPVWgTDmRvPENHLgK3EW88VIANh+ddZ3r6U/u1e
         h+PmAn2GIatEyz80Toz/sts1i39+gvqvYevQNW2dRbCcALQVlLWP/tQdlmzG0P+1Aapp
         VTXzor56PFRnBrmSIyqQXLTCXIdH4/qkgTsoxx+TognTzxq6FV26gH+19NFNamSF5F2T
         HySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758830; x=1762363630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ia7dy7OugzoaAdNmxRXs6VrxDzNCl9Ybf9VuqbvbOU=;
        b=bqviQXjgHCFrK+tX2IBd7wD8y0yijuq9WWK4K9YOxK+HQG9UO8TkLtTuvoHA1CpUj8
         QwOz+z6kQdFWaX8zm++OoKiUjeNZhYvJjTTz8pqJpPHnkTjr75NUd4rJ3iTo1VSUOkhD
         DEnUZVrNwv6gJO0TMnc8Z1q1XwcoKEuFBthaj3H+/+0tjiFkdU5J67HWhvNn3i+No5/D
         Kw38A4ujJxMRNL3WKZk1e0tTQmzrD7y6dwYNNnbP/Q52dk3KayVXL+I8Ne/BNtSNC3zV
         /hWwr6qaOdDhWlBK3z8tFWIeYbPbz/RqMo+5zqiFAH6JXE9cYPydMRNSNbdK+Aja2v1I
         3HIA==
X-Forwarded-Encrypted: i=1; AJvYcCW9bgX9SYNbQrY073xNT46m2YixqxIefBquZXshO60LtqbfFjyZz+bcVNqEp6hNhx+OaDaApheTNTbIabQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnAEVSX2Kas03CZPK+skrjcw90vbrV9hfQXip7kSZnVuhYTid
	2+aWCN1eMWnUv/cF31Jf3MZiTSn510vzX3JNCzGx1u3ha42Um2js0+blb87ffeBGrwI=
X-Gm-Gg: ASbGncvlUUtyoh/cqPijkxostRQF/utC4EX7+AnO4NguJNvn7dQHADqcfn3B9ak4GRn
	a7BHEfreIRaPpKVF8GvyAVX+if4HJQXfO58wlzzf1ILqddnbb107KE+/2XSCNh5W8SEB9xHwqTH
	k/CmO9EpjsbArckpqCCUGfd5AL+AlQSu4C3hbXogpVkg7clnMRYpTUIJCnvlqce3eLYWSbhO2HQ
	ciSeLNKQ/3925sadw4w1bExVrGj+dsFtyl4GZuWOYcVb9jV6phvGUhM8Lubwj+0RvTJN/u9Q0Hr
	Eak4nRLYsVoY0qlQVR+ztq9vATcIBnK54ppO8Mq4pX1I0oPVIqOeUWYImdeMuQScC8AzIMWjSdm
	NB3jktILOHNMRC+FmdFCcIwbxlEmppiyEqzj1YFsYIsjrP75jw3bgqwk/Vwf43dp9RgftHqB9pH
	Lr08w7z9ECg21CsYRg
X-Google-Smtp-Source: AGHT+IGJ3IMd1rSv4GAClinjHOiEReAmo/f52Hk4MgE0Q6oLLDOo6tjGWO/OOryyv4rktxjVDV+Nhw==
X-Received: by 2002:a05:6000:2388:b0:425:86ca:98c with SMTP id ffacd0b85a97d-429b4c8cbabmr389095f8f.28.1761758830020;
        Wed, 29 Oct 2025 10:27:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952cbc55sm28319303f8f.10.2025.10.29.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:27:09 -0700 (PDT)
Date: Wed, 29 Oct 2025 20:27:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761753288.git.dan.carpenter@linaro.org>

Generally, syscons are created automatically and accessed direclty via
MMIO however sometimes syscons might only be accessible from the secure
partition or through SCMI etc.  Introduce the no-auto-mmio property to
tell the operating system that the syscon needs to be handled manually.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 657c38175fba..a0ad12ae0bee 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -245,6 +245,10 @@ properties:
   resets:
     maxItems: 1
 
+  no-auto-mmio:
+    type: boolean
+    description: Prevents the syscon from being created automatically
+
 required:
   - compatible
   - reg
-- 
2.51.0


