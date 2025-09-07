Return-Path: <linux-kernel+bounces-804716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2090B47BFF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D44B189EA1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9C27B34D;
	Sun,  7 Sep 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB3TkaUi"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A927CB35;
	Sun,  7 Sep 2025 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757258348; cv=none; b=eH6ES8lJWGfza8NSKxQ4e2y/wC/wjh/FOgekNrqPlz5MekPgnmo3wg0MLP1bE0y5fs9blu1OWdzxJKmKZ8H/3HY+3A66BJ5c+njhavv/RgzXRdwjev+pN7iIEgb7Uar77LqydzTE1FkDlbU9JF4RAZv53/p3/ObGj5dKEZdBkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757258348; c=relaxed/simple;
	bh=INGgVfqlKMHIsJnk5/uF8SIZ5T68ofb0yJweD2hZb3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWsO2ZzKiaezdjajfnbrQS/9nGbIKTldCzq8PnlVJTKvscGHGz4gs54pjHLXYgNyb39bBsxoG78DO/nM635wkSGwpLujtJoReALQPpQr0eJnWbQfOIquwDlxOD9rNoTdmkwMCL56nquRsmz7Ns7Nl7Z3BnCGUOetgsW7ogX3aKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB3TkaUi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so4399119a91.2;
        Sun, 07 Sep 2025 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757258346; x=1757863146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUQTKCXW68doAn9S5+re2oA4gZmrfStdVGYj6Lvuu1Y=;
        b=mB3TkaUi61ewrBi0ZUZ4QGdSWcq8CkFZ5d8PR7Iayv26SvbNX7J+KBmvpjBIN7mI2h
         2P4LvSA77HXuNN3FTu1oajwNREceZYCeKvr8g+dW2H+JRY2Qp6tjn+eemoHH6Cl4ebMw
         r58rGGsFq+f8mXT9BHrqPY5uUQlnAeBcil4CQ2hVLSQ/Z0GE9T9GapV4GwZ86daTGEEj
         dtQX53UTroRmXEFLsnx1F5Vv/w6swgwc1Cql7wujr9Q2mGUlVlzRd+cXxhq9lR3mi8pN
         ddNBwGU5Xn5iS2uKHByBqj2yMYvSCJclBxXbJ4dWZuawiKvxlgAlOB+/dcrRkzM/F/WY
         bP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757258346; x=1757863146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUQTKCXW68doAn9S5+re2oA4gZmrfStdVGYj6Lvuu1Y=;
        b=GIpJmbDbcf5CXqDoDQGZ8XHPVpG+IKjUZQLLuIiNNji0fdtq/IwuAoa5WBumtJsG/f
         u87f8V+oJQk9TZgMjEROSnQCkgweq95GJ0dnIAKGq0bIv4KBFqBEi9UCbSjLo3eeMtm9
         s7z9V4I09JtZVBp6jYXtyLSwoQx+UvOAat0gf5SiN0uNnggtskZJzzahCiFWLNzo/4fR
         PXfGOpdxm/dQ2AqENXvDBn34J9mPoi1a7bPV5g8ogGM6ble5+sbwYNN4ucRdGB245RXE
         +aQ5qNog3FL2GsBO37sIJaM68Myygd0iCHslT1GlgzL5WgjC0nnlJfxfE8iggQOU6l6y
         GSWg==
X-Forwarded-Encrypted: i=1; AJvYcCU09zY4e4RhcbP04+/0YJDnSRbyXToad6TSW/d0KlcaFtDm8IwYAiOK+qkSiTvc6NjQThtYfpAPYLVAr7D3@vger.kernel.org, AJvYcCWfDc3JWiojFm+PG+IIkTNiUIOMhnfMR8+xzaNcuO666UetBBjYRR8iEutwg7kSYZFJuFuoSILglxal@vger.kernel.org, AJvYcCXBG9FRoyPX0/WRMYz3J2gtk7HqgwqNH6K0ITF6+JgNerTOt+jEYXmAqBcMR1DYuB3u6/ofEAVrmIDx@vger.kernel.org, AJvYcCXT9bHfIM3KuswE5kYO1cU6RSOOkqXM+TJfF0UHlia5ZkzpvEU/FzcW7a6tH70aPgYvDJ2OQiQPURafhbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvR70TkHVj5Xw0sZyThAxtC0HFKr+oLtJJ6i00Vht5jWxbwbsV
	Er0MLpVONtc1Oz/fdp5OypnufXgHjipHeHVNpB6TmtLyE8Q3Ckv1StLk
X-Gm-Gg: ASbGncsk9jCiK73fOXYbS6aSuyofJRn76RDz0SXr20ON9OUtMzEdirad6IOJEZiJSqy
	wSgMPFhQTYGjxpIbMFmL5nDhx7Oi+8GdW+YGPx8YiKF/3irBQX4fd0TUpWzvb5tf+BIGIRm3N+d
	RzahGliPavfHAVKjYQo7s/nVrqdDq28nniAswdA1uMrm51NpTdEKQmUUaK3OgK+SzAEhHX4mdNo
	+lTNSOHUZ5Gz9v60wZ7Rq5likphvOKzrZ4eKjlbGtFZjVb+Wd7avJ3hrpE7oTcIrv3lkmh0uTYW
	6sYL3LTAQpdzBPXmLqV2GHmwQhnrL1GWCHZz/WkjcubHPHl+VLgCmgH00l78E97KfK8PPLUiQrU
	T/Ro+FyVf+jsvjM9VQ9SHRkdzdx14pl7NXkYoIiA62u6Bjw==
X-Google-Smtp-Source: AGHT+IGHEwMRYqRUc7Jh68yeM7OA4SCGJ6TAJgyX1LESgjrBTlK+b2WgD3grydCExtFMoLXDGZdx6w==
X-Received: by 2002:a17:90b:3847:b0:329:f22a:cc58 with SMTP id 98e67ed59e1d1-32d43f47341mr8750459a91.12.1757258345912;
        Sun, 07 Sep 2025 08:19:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b95d31976sm10199481a91.22.2025.09.07.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 08:19:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 7 Sep 2025 08:19:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] hwmon: add MP2869,MP29608,MP29612 and MP29816
 series driver
Message-ID: <741692dd-74d2-464e-a162-a1fecbbf5d4d@roeck-us.net>
References: <20250805101754.749492-1-wenswang@yeah.net>
 <20250805102020.749850-1-wenswang@yeah.net>
 <20250805102020.749850-2-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805102020.749850-2-wenswang@yeah.net>

On Tue, Aug 05, 2025 at 06:20:19PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a
> and mp29816/mp29816a/mp29816b/mp29816c controller. This driver exposes
> telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied.

Guenter

