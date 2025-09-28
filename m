Return-Path: <linux-kernel+bounces-835209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F8BA681A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00331899FE7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2034298CC4;
	Sun, 28 Sep 2025 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhqbWGta"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCF21D5B0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759035717; cv=none; b=ZS//wi4IhEmcfk9LWpdQgPIAMBfoaSuPcSOrevPERWoySaAE+uQu23teGLj4SwVX4OmHxWXLUN5JNKR05SS1OKM0JGR4sSBJrkvEmONhlZsSiisZTU82LbJ6XjJbl7uNlz5epDi3tompg93LI6HPqA0K4pVx9055ykOOYkNV28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759035717; c=relaxed/simple;
	bh=2KAdNtvOHAv0iPsSzF6JnRSyf3a/6LV1XFGg4SXH3dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVT/AHK5bF73KLUqWly03mOOKt8bIpuNnNCqx93v8/yss/ymx6OeL/f7ZKmSg1ZCzLHk6GthgAVu8J0bepOldhF/nKww5FGyprazIIaFk3377GsIZL1lLpETovSjmWMYPQ0koepR2LmbYVEVGzlKPCZtO2/rLeSKEJW0OAngTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhqbWGta; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eceb38eb1so41583745ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759035715; x=1759640515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0U89y2eMhj2iLIuruto3nVeAxA529zvX5Wm2O/HQL8Y=;
        b=ZhqbWGtaxUckOZSo4F4tbV5mdHQNP93rvyc5CDtQc828TQYK1P/Fu6cwRu2T6IgQHj
         1HRdfX7ogs82Z3WcwJeu64ibnmZb55Ls6GmwoIxNdQd9v1UmLxWCeCI+F4f81Fcm5XIQ
         RB2T74MK8Junbjh4pJQ0tXhAFAGsEQ6U5FzGxiVVtS2wZ51i0lhVWEKNpd2g6IAuzyTu
         EF7mUtmjeE8FbLpL+3OLTc3/Bzon/GuG+GViechN1RvOVvX7rhnAQGOEePa1KWez07CT
         60itKa29/s6bevw60s3zK3n+a0+c4xc0xe9QP8YGbRdQDZtxgrM+tMrvpeFI6vKwt+BP
         sDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759035715; x=1759640515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U89y2eMhj2iLIuruto3nVeAxA529zvX5Wm2O/HQL8Y=;
        b=iVPADsj3yxnhAL0cbZH6F5V9lNfedrRuB5RQ/oeTwr64ZPri6m8e+GDYYcRZ32IpfO
         7bUq3Fr2y+ENLbNHOB65qDUUDbA0IIDsEh8sBuCYub+2NTsU8R9hKIIZfoE69ogESaEU
         InRGtSX4ee2evHXNj0UlrK/z2B5r85RmnizGv432npOJgEcQnqLJbP3jFyt9zesWfmKJ
         FiSNHIZQUzk99oLcEVRUX48Tw1f0Hs+hkJgPaX+tyBjgpM6/+ppCzk4MtWuE4O/KrVEE
         h/wwX6GiTAccLIlcuula1jN4/VCEh5VHIJ0ZlOuJP9JSgroenKMOb2QkYtVfouzYCrDC
         nKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjrjBi823CO06RCVThzF+5Td8zC8KbLn0MuHshp+oLYCAi5GBkCu+Z6asme8uckhSziafthGxyLy3D9i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyFdSJDGkyQF1FR2SJKx3k+y5KISamZJm1pFg9zToTl8SFJQp
	Yx0yfRBnBTgf48J0xiSAjDLLivoEhmaGduXHBzg+wq9vXaKyXRbs4imK
X-Gm-Gg: ASbGncskhhRk8o/xRfkqz2kQpw8FLk7n6aoPfulp90QgDmzL6ty+Hh3dCWQ9qO+DEjf
	uIUDk0KC8E2QHuY2oxI9cVM4YYMmdzq3OST0iO00S759MQrU8aj23ek5wGF/gNizyLpPRME61ap
	UveNtQxzKIzNffvXCu7yGmRVkZMH+xhpyLuuv3StzyB08g9F02KhdL6fGCv+gNLJw0abrkX/7iw
	oBeCvpXk1RMu0C/nWTdNWJIUGiUXhvkM7lceojinKR+T4rj+UFfK8ET72WiB5ZA2vottfwa+UZr
	7QKFIOIA86LuMrjVVMYaEc4YIrBoABm3Bwp9WB/Wj6Jf09csxiXPa0pfXAxYfojJmMQ2uSrzysW
	Aa+UrrddkD96XM4kPX1agTrGc2VO5cm6o5JxAOpWj4hckf4UqOs2KH7N0mhRkm4qQ10lCOFAD0G
	gp66UiTFCZ
X-Google-Smtp-Source: AGHT+IF4gSMaafr65leHEt79++HLMxBmNFlxKbU0qyU/KcJdtn6/e0eUVQSCjElsKiida6VyLQveJA==
X-Received: by 2002:a17:902:d2c1:b0:269:96db:94f with SMTP id d9443c01a7336-27ed4ac8880mr159569835ad.49.1759035715125;
        Sat, 27 Sep 2025 22:01:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:22dc:7b49:8c5d:38f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43ecsm96573425ad.24.2025.09.27.22.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 22:01:54 -0700 (PDT)
Date: Sat, 27 Sep 2025 22:01:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v3 1/3] dt-bindings: input: Add Awinic AW86927
Message-ID: <rudd5cgaft43bjllspx3cb7wmcqe35cirtwfuf4b3kcntpxjad@4un73z7omcwc>
References: <20250925-aw86927-v3-0-1fc6265b42de@fairphone.com>
 <20250925-aw86927-v3-1-1fc6265b42de@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-aw86927-v3-1-1fc6265b42de@fairphone.com>

On Thu, Sep 25, 2025 at 12:07:28PM +0200, Griffin Kroah-Hartman wrote:
> Add bindings for the Awinic AW86927 haptic chip which can be found in
> smartphones.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

Applied, thank you.

-- 
Dmitry

