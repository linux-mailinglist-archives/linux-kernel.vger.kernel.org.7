Return-Path: <linux-kernel+bounces-734224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF2B07E92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D1B5020D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4882BD598;
	Wed, 16 Jul 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aubYVSG3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30B288CA3;
	Wed, 16 Jul 2025 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696560; cv=none; b=Nhi19PLxemmP8UMiL0GXTJHhhZx3JEn5v4U3YJ3gp1ylOv+7jjngJSDsgHz8JGMv9pWK0L91CpjtZ0+++QG+B9DsOPMjUbj83LgHv0gDNptJrRPum+6REilu3ZvBDtPXJyZnqY32Jmf17ZDWqGxaaKKqtUcQ5FN0v+75sWG/LpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696560; c=relaxed/simple;
	bh=95JvQ3xHfEvUSpi5Ye+EtJ1py0S0m7W4L7K2mPOH2WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbUGQWYEmSMC5o0ZU9+oPOzpFP9IRPveov+RfUty70gTTWzLjDD56v76rztbP+mXw6xTduQ7MJXGyUXoLXNyTcAhMkvKlNW3VMagPapM/GadhR3+BxyBeMj/A5jGbF30zgnH+JJ211kdFECHCW19y+/vHAuuC0iam6Xp/lncsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aubYVSG3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23694cec0feso1981895ad.2;
        Wed, 16 Jul 2025 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752696559; x=1753301359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rF0odul5VI67P8AAAXp7dHv+38eCPUvJmNFiIdA961s=;
        b=aubYVSG3D1UVUnM25qCO5E9L3IEaIfY8gOggExnwOX3U9DpE8BirtGmwL0KdZaWT67
         y/E7j8tBI2p9f/ZgC+KWNjo1vysdjzE7Rluac588bMNfmy+wIgwhNAPkDysB6qWBpGXl
         oMiIcnrwxDaBhqhDS0FnS5ZWJVjBB3ImRxK/4YiQm2gjWZ9TcPKUn4kDhTY5cq5a2yX4
         CnztThg44aOOP5U0TMhKBZlIkBI28twQ2DdIBEbUvggLhFVxdqvmNCpL6Ukfgpt6FQd2
         UdkOJC1Iql1J4mnDE2/PrWCQdNDOnHqLEmjtEiir7bj9zZ1W83bO6TiZY5uKp7rAPjgP
         9QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696559; x=1753301359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF0odul5VI67P8AAAXp7dHv+38eCPUvJmNFiIdA961s=;
        b=AdXKOmvQRGU7hihkzoxHQakkiRsy3P27Z6tFhuDbP3nERpEj2CHbYXaVlvIeVB0L6k
         BX7ZQfS17D1puGD99Ci9FuizMnIEOUYb11SOaBnvprf+YBmc8g3/OGBbQ2GIBlyWSU9y
         Jv7fAipcKFOTV2UjRdZzB46p90uvV/ENoZZBxSqYBjCRr0KCjaKB30Q7GZhRDLIBF8LG
         UzjxHiLv4R+IfJxNltZhuDBD3wFcCBubhJJ9XqZL0pYD2agwPY4PnvS4vatwO4D1/Kg1
         Kz5MF703Sw6tczXnSMYALaD50dNg4vg5pwu2yhAReXuvQSASabO09k4ZCYCO0AQVwbDa
         YZLg==
X-Forwarded-Encrypted: i=1; AJvYcCWPWtNi+M544ur98N9x8pR3v3ktQ/T31k2dLJ8SqVCQ0ejxQch2R8xrElICP1rLyNdK3hEq7WtaQlDR@vger.kernel.org, AJvYcCX+A2ki8gxgCxfiQtD+/evY+COz8s8KBaJeAzTlyqNrCpm2hBpnxgT0akqxkjlpgpTAR1oZmfL4eOet/ek=@vger.kernel.org, AJvYcCXl2ZsLV3rcMMYTOohi6AfsfQ7n7k+S/TOOIP1gxrpoVHTcBPwvgD1otUguAiWvLNclxB9Na/3oTSirZh8d@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBPqcl5qYBFH0holkNddzBIpXEBNpeQBOusBinH1uCBoeHPqc
	GIMh8vEZD/I4OBDCRXZn+J2MZ/+bjDatMRqA3+puPYna22LpFV2MfQIVcxx6eg==
X-Gm-Gg: ASbGnctQZhNhL/4/DBmUNWb2hAX7pUJBqx+svUbiQoUhq8JweLcXIkrYdfO3YO513im
	PS/zX6VfCVfz7RXt7F94sKwzYQPhj4dlbdGVm4KJN7EsFRl4haPBvKbuxboCgQ7GUDckIYGrx9y
	1N7Bdm7FErhqhO+c10CFYSF2MGpdo554vqnQTJYLvYEC2NMD3iahe5bL8rrpBFtpstKhF+zssB4
	U5XJq2NQIFeUnE9+V4ZsVdBblfgxSTcYz9mpfogeRJtUUGulYSrvORRhQFQb6sbKSR9TqMduzlR
	jvfnweezwpctXD+77bhXRGQji+rkva6GjvwgWuXaTzTTCDgUY2+F9+aazyJ1sN1jxainIDhffVi
	ciiTkYWvwBxj06q7ZAcA0HUcoen3OtJuKHFE=
X-Google-Smtp-Source: AGHT+IEUWE84w29OZqLXxcm71PaCF/KDwsqNNr0ogmhn6IiipDgBkaXnVfedgHwTCXOLGm92t+FB1w==
X-Received: by 2002:a17:903:183:b0:23d:fda6:1aa6 with SMTP id d9443c01a7336-23e24f59be1mr58110615ad.41.1752696558560;
        Wed, 16 Jul 2025 13:09:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42864a8sm130834635ad.42.2025.07.16.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:09:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 13:09:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chiang Brian <chiang.brian@inventec.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: trivial: Add tps53685 support
Message-ID: <581f899e-a56b-4e6a-a1a1-d8b76636e81f@roeck-us.net>
References: <20250619064223.3165523-1-chiang.brian@inventec.com>
 <20250619064223.3165523-2-chiang.brian@inventec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619064223.3165523-2-chiang.brian@inventec.com>

On Thu, Jun 19, 2025 at 02:42:22PM +0800, Chiang Brian wrote:
> Add device type support for tps53685
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Chiang Brian <chiang.brian@inventec.com>

Applied.

Thanks,
Guenter

