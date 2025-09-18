Return-Path: <linux-kernel+bounces-822062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A971FB82F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18A7583626
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707D2750E3;
	Thu, 18 Sep 2025 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UahEEE5o"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426121D59C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172197; cv=none; b=PP3Be1hhZ+SYRPRH3d8IPmnW0U+SiW4XG1ZqqaaY/br6KRJKDcT3x6ew668WWgLfwo3JtRI+kkhUBKxoR0Y6GzmWWKLacgG1PS0GPinVBy0LJIyDZppLXC0CEWMm5rKPQqbAK0oWZe0Z+IaXemr5QOQqy4rBjvBAxBdCEgnK/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172197; c=relaxed/simple;
	bh=cSJ4eUM0DsaOhlcWfrSZ2S7GNwrJAdc8Rw5tLu8gtJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+gu5Xu/toNqR9gd2xgp0ErwzWieuHmwEYhtB2+u7PxTeXspvhdab81yI2+2wQ6XsyBnFoh+KQL70UmbaeDc9FTsAkhfvWnBoVRgULRO7v1TeaCZGpc6HcBX7ujnUYSx4dZ0Eda+HOGkTkDTNf9rNP/J3DAb7TWKnE/IN8sujzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UahEEE5o; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-330469eb750so582921a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172195; x=1758776995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzO5J5b/DpAoS9q36wSTyxp4bWMYntWCRlnNr1Ul6mw=;
        b=UahEEE5ofyyXoY047oataLzWhTWmrdVjWxR5DajFp+OW/RVx96mNne9PEwYgxIbr01
         sgobGqqdmp2eERbWq8df6OZLLXGMAyJgQMKKyG2suLXyo6NIaoOV+BGwOSE22NjicMel
         NoqPDcPuPDxfug2zTgMlZhWlJW84LhJ8PlfdzTMXmwai6XBmuWBLsH4U6az6OMtipAZ9
         3dm/yo5REjUVgpyrCuAeDnmsF75hdWp7jJNBewYHlT/ylEf7W9XFTV0jTb0/7SpxQ3Zg
         GNZe8podHYoL0RGhGMbozcaL1cICuAplq+K/b/RfqegoxOKsmA4xuNnWGmaFT61da3Je
         /Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172195; x=1758776995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzO5J5b/DpAoS9q36wSTyxp4bWMYntWCRlnNr1Ul6mw=;
        b=k/j1JqzvNoJ7PLxmT3xcWUOBs7DV46BQ4UO4rss2o51xxnw3suWbb/xRifSJQEGfHi
         jZNPW4SB96HkhX/SUPtMnkFwmTv91oVXgOmzP5zkE/IGWAksH56rYMRoTTPMR5dOEocH
         NgTEONdh6uXXl+uSsiVS6fNPXtiKAmNe2qfrCkWc797/NfWcfBX8gqI8G9zKW6l4gCGm
         ig5Hn3/y7O+mSfV1eFbxb7oq+NEngJxTo4x5z9IXJW8lCv6f3CdTDbL9tHjQckc5GeoS
         Z7/4WNo0Ng3C3gf0z6WjYkEfvohVhrZfm7JSDjSnviQqaWKBjTBoDPzzq4Px36Iwt9VF
         8eow==
X-Forwarded-Encrypted: i=1; AJvYcCUzWMX8XIeCheRFdDo6ztLAAUr5+iAQnuB56wEA9Ad4qP76h1Iks8iApiv2eWpaBw3CAFnsbBM4C9+KMtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65OwIcd278bMixACzkn3gG+cw5Ky7EPSpHMd2JRfxz92U9w5s
	62MfMmKr+sjm2TcSprolhHK9zVxa47pLF4jQLy0Zl+oDJLsxcldSr0aa
X-Gm-Gg: ASbGncvuYil9t3E3GcNKYcKAZbLIhohbj53rCA9gMDKkcwsGVEYGDEFyRYY+jxa0cpA
	AadkEj9zo9AGl3Y72xZ7z9E+sIU29KsBLRa0YBDuXbJfaoxzhibbQC07EcpcaE1fXiDC9lsftIF
	uoXWQcpPACNg5sZBLeW0bHgELGAlrEQmMQnVA1eQCg/LLANLYIeWHqZ6csBUsLJ5NzHPFByozzZ
	VjrdQA+febYDxDbwbMy/8bmgHcD9CdqCV5rRVgnjo/ue+Glwz8qmxcaj9H2lIc7mW/lpRkaOggc
	hUMioqBlBnAqVzQ/ukUyldpxOxpVpHU1+Z6bCc8KJZItDrJxs5XWULDOCap2ic1OZV+hv2J5nx4
	9q+9nVA5rbO1YV7O1ZzZ6S5mmGkHJq6ow3OWDeLIDHpYvliiKutHe
X-Google-Smtp-Source: AGHT+IEoyQwkdhcbO2KKAnocbbWtxOraH4oEPJ9rZeaTPzEToqLKVmqvC+7go7FKKDfNLNeEHp+khA==
X-Received: by 2002:a17:90a:e7c9:b0:32e:329d:3062 with SMTP id 98e67ed59e1d1-32ee3f7431fmr6979916a91.19.1758172195070;
        Wed, 17 Sep 2025 22:09:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:194b:8358:5c91:3d3d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed278b065sm4122687a91.29.2025.09.17.22.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:09:54 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:09:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: input: convert tca8418_keypad.txt to
 yaml format
Message-ID: <htwupxwox3c5fjvjr3nxc5qtotgnlesit2jnswg3g37a5tku7t@npyzyv7mtwr3>
References: <20250916171327.3773620-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916171327.3773620-1-Frank.Li@nxp.com>

On Tue, Sep 16, 2025 at 01:13:26PM -0400, Frank Li wrote:
> Convert tca8418_keypad.txt to yaml format.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry

