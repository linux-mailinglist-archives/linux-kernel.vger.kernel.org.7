Return-Path: <linux-kernel+bounces-731725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B767EB058A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5762178E63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A72D8DCF;
	Tue, 15 Jul 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1q7kTar"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0A22DFB5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578649; cv=none; b=iVqPKI4+txzGyQOD+BeYM0NjE6AwSHPr/1R4YU83XFA7BoogD/JebQKjuDARcuSKPclEHd2HROfEAV33dREGJw8CQz3gtp7rDJvZXqzlrWB9Rxr838xF68oNZjhtPvhflqNlBTRgPsSEjNlQim74wxPhNt3Zg3Abcw0x7cR93jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578649; c=relaxed/simple;
	bh=N6davSYVMRS0XhnGIJVYPBr1mWvE2ciYQFIEowvuido=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llnffml0RrxYQsMh6dwtL5WtShLJSm3d64+aI5bAjV4qZscTNv8P4C+WuUOf6SA4EjdSJomjmDZKfiADMLjEIbeOTRbYhKCiBUq4obR2x3s3L6d+vxAgthRQ0mF7LQyX4C6uBIj33wSFHQsggykD6nkKCfdV57VfEwq1if7O9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1q7kTar; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so4119284f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752578645; x=1753183445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRMRsPbK7uVIpCz9kv9Sklo7hdMZKeTM8NQqJUudn4M=;
        b=N1q7kTarZei2RxMdYQxLRddc5MNh06yn2SSjTny1fj2TKbI/ec9hIaAodARGD0V8mG
         NC/3XJt1BOhxB2nEuxcm9KgdrC1f0YIZDNwa3dyiM3tMrQkP3b2/VfyED1t2avb8wxrU
         LhKzQh8kCOSQQA8/WWEYXe9UD8u7BznxUFURUfdwnMUpiP5FxQmQ3QcwvuDHOi78qg7H
         lmbto/A+fB6qYOfI881ipoVd9PxWu5NOAIAKJIEFpC+wzAYUcNKmdbJo9+w3GmoYUuNC
         l34Xr24V0ylKE01By53t/PAEOKmLuszsTeHZFvx5y4USYfY4ybgySmb34d4/C61u5/pR
         nBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578645; x=1753183445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRMRsPbK7uVIpCz9kv9Sklo7hdMZKeTM8NQqJUudn4M=;
        b=UAu1J8l8dXbLR0NyAgWITF5DxudMQqVrDsaAfOHXYmbt2ufoQ27hD91ra7rBmWaM9X
         Fc3w3jRPFKj6cgHVWioiofn69bJe8n9oETVt3PH7tk5FBZ2TIC1xVebAbBrsLkW5n7w6
         fajjw4em2oZmUCjI//WoT0cRtyCmGk2VG6XG5dWGouI7rLMqq5mflpiwyMSkujGZ4ijq
         +6RpjP0kP+fR7fFtCricUwr9+kN/a5HwhBZH64qzuAhTfrAkmsjNqAbXAG/uiro1HQnc
         EECGOTU2t74UHLvHtB7NnnXB9NBSQV3l0K+i6Q29C/xyRTLgV0V/GhW5dIza+mu9KS6D
         Y+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Ou+AdNU2GlqzMaaehfZdUKWKZhgj9SSMvRPijhx+lC7p+53kP5klH4fumb6YZrRP+vJYFy/Rni9BaKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5Hlqs6EfnCqjkj7gSFCz/isd8gOznVPNPIjVu1vmouBcB3nA
	E2GAuOa5UfD8RH8JPb2s71ELi6Pz/DXk0U+W+62ls9NgrkAun0O+OWquI+4+DNaL5HM=
X-Gm-Gg: ASbGnctGdmtziBpU45horSQwsQo5qYTueFPywu9jO4WS0qs2NHAr7tEH00RXKmEQf2A
	97LPDEVHPtlvHbxj2xAf+v8ez+LwTB66j8w8+6UU6S2VbtlbC5OqJPE1Nl2NCrWwMkTIqlprBzD
	XzEOaoF6Yqc2mjGmwXje4ZIfZC4o5E5mwqr9H7g5Pe+2E6AxScfneMHI/9L234j9u1RZohd+C+a
	1OYUZaJVf8fR0vLahBRoulJw4MEjUOfM+gVR1hxluC6MYgs7+lSpaL4Z7IBnPOklNIYIBtfdFDh
	iEY1C/zhXEY9lDiBL6FmQAsNErfaGvZLp7LzvBwhOzu7PMFzy1V6jxyDKKE765+lQDhXNQ5Smvr
	6ZonMqvgYjQ3dAUiW8x0Kd7j8+15DBXBAQ/h42KRf9duI6c7jubBXl6igtPPi
X-Google-Smtp-Source: AGHT+IHVswNM28EMS7ZkEHWVkngG54KZ/Az7bLGLzT7TPBhCqk9Wfx5NrWIyPX+vOu46nSfZllym3A==
X-Received: by 2002:a05:6000:653:b0:3b6:cdd:a41f with SMTP id ffacd0b85a97d-3b60cdda4dcmr45157f8f.4.1752578644731;
        Tue, 15 Jul 2025 04:24:04 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f32ed100sm11943318f8f.0.2025.07.15.04.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:24:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:24:02 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: cjd@cjdns.fr, tglx@linutronix.de, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/timer-econet-en751221: Convert comma to
 semicolon
Message-ID: <aHY6UjdYy4lTuonf@mai.linaro.org>
References: <20250603060450.1310204-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603060450.1310204-1-nichen@iscas.ac.cn>

On Tue, Jun 03, 2025 at 02:04:50PM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

