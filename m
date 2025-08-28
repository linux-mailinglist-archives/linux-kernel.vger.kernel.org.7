Return-Path: <linux-kernel+bounces-790743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057EB3AC79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC016200C60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6192C08AD;
	Thu, 28 Aug 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBC17phE"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E56293B75;
	Thu, 28 Aug 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415206; cv=none; b=u0ig72Gho6DIB4YgQCJPfQSikmmkiZNRAXt1YVNh6FTcnrDvcJX4X53bgDP3TPyw0chtixY6+YU1dTmlKdz1fusHQU50L8PHBrYqn3fjJWyH8W1rIK0DQNxltukzcMke3EFXyqVAbNlnoX/GkkxVgzyEBw2pWjFGFCB0NAsvWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415206; c=relaxed/simple;
	bh=aU4HC8UQAZSTU+kxOsaBW7A1xIxFHjB6fPNppFMLwls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GquYvPIQ7LU3hBbS+GZxgvhA4OibKOFOANFoS9fyVhNhEdBOfLPd2biD5v7aZBX7GGxTbGVsyMDytrqdsMeoDuUjYJ7vD5WgptlUQLhv0cEhtWHX6bFX0zNdtV0l3GiltWVZvrjjYph2Y8GpYLFjRqm27u6yQPxaWCpPZSyWENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBC17phE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so279023a12.3;
        Thu, 28 Aug 2025 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756415204; x=1757020004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9xiphXoFi+TOuk5UJpEpjG+HeyF17Hj5IMdtROU/jo=;
        b=HBC17phEsla5LYdbKxp7KtdR5Oz2aBT3+tHCcfW+PDJ0+h5FJu2h2jNttgKbb3xUSS
         shwjl4bpy8ZnV89dOCh4fc6SUE4QVfSTpYXeVVHeC6pxo2+aI+X96S0lhuGwIIPEqtCd
         VRXq4IyDR8CT4ihpGwCsqdm6fek+nlAVWqhmaD2vb1Mq3oQ7U02ZceW9qCpT3JWKQ5rs
         lkAB9mFv9r6LAyLwN/Oo5S6N9nAoPQZfphuRqu7Q7qX34orFFFsngIS1+ElUlvfTLcZG
         mFm3Xn77jrezSHI9rmeZRBXFxk5NfuNV884Me02ti33pZ07TkV6VZX3oHBvZKH1l5LJ5
         OXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415204; x=1757020004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9xiphXoFi+TOuk5UJpEpjG+HeyF17Hj5IMdtROU/jo=;
        b=rGPn+jZP5gyOtuR5Q3pZPE9Vg1XruwVhqTdNLQGFvCDdRPn7dxLZ353EmXyUmkjRD0
         RAx4oFDqrLlxyt/VFYgeeUEdFivuf+2IAd1g8O95mnY/E2tN5QCgAo7HuwgHiph55K33
         VnLOavl47dqJtnQZ9WCfD3gKgI0KbUvnOp3gSfpkOCBcbg6rVn3lON1IIG+LErpry678
         GZJbNIjgVHlzKgcniM2ycI7ijzpWnwux8qxgPhLmYbfYZsrYqsz7ej8ymwmnf1Ag7xho
         Bfnvu94VrVXnfghZNhGAR+nE/K23xIoYLCSWo6+EjDy6/5GOSmOGWPJK2qn7s25f7stz
         TEug==
X-Forwarded-Encrypted: i=1; AJvYcCW96r1zerPr/dKXKv+9hzom8HqSijwj3d0HBJkTUqQ74Zy04Z/Xej3xZUOFYN1A3/68AOY7vClpgdy7jbA=@vger.kernel.org, AJvYcCWsvU3lTVg+2+BJZplfoGP5FRN5L/3xJZw390zu2kIBXpvsKcHBuSLeU9i52FXx7gy2Nb8HnC1rZhR9MABB@vger.kernel.org, AJvYcCXkqmiHGdfm8Nsc6iFI3LbQnKbo2G1sCFvYhqLOyDxtLY5ePQBkATVYgFGRfVCGzWbxqvXvKUxBWh9W@vger.kernel.org
X-Gm-Message-State: AOJu0YwroY7caEL/mzR26UK6U4+YNUy4AYrDiNWHFbPMZ0c8RWejNFGT
	ILMuQ2456utHrtb6Mz+FqDA++UUY/15hHRzX83Kh9PwH+wOGaRJxh2XsHJxalg==
X-Gm-Gg: ASbGncuTvBFE6SV49FYqsI79RlhNFBJs9uoKOXrIq4qfcHEdREB1UzwGwka0R01IN4M
	EU3SgI5Cn7U2w29kTDtLyO3rBeqTXbj+EKuv96WgW5YyuvYNRN0+jHMc+6yiBkWjw4zaNX1FyIT
	xNWIHXNbyiHVucyImk4gVqKZgTFKnQW5nJQVw8emLzTT2DS7ByK9zibU36meQNYNxru1vcQMDLn
	XLuHE9g6qD7Q9dNv9GznlDPmibEhUyPIq57Ovyk6vounecrWiplLPZO5S5kb8V/dnA+vPVuT6AL
	+6YSxr1MlLgt+ivfcKCSgo1MYBAj9hjMW0MBQNtD9IeA9AhzbqB0vw6A+vQ5A7tzWeHN/vhiNpi
	MUbp3QonMiHguFUqlY7X4sR0y7/EaubOMlHueLPVPzCexFA==
X-Google-Smtp-Source: AGHT+IGA4moSPDDP3pS8kDGojBWofW1FabFnmT+OiKtLPsVcbcb97vDnvsXDXur4e18J+FeSJPq12Q==
X-Received: by 2002:a17:90b:3908:b0:327:972d:6e79 with SMTP id 98e67ed59e1d1-327972d86c7mr7478893a91.21.1756415203812;
        Thu, 28 Aug 2025 14:06:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d932f802sm622257a91.1.2025.08.28.14.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:06:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 28 Aug 2025 14:06:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Grant Peltier <grantpeltier93@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, grant.peltier.jg@renesas.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: hwmon: (pmbus/isl68137) add RAA228244
 and RAA228246 support
Message-ID: <c1a87d21-c8eb-43db-9d7e-6c67e87815ff@roeck-us.net>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
 <c0c6e99e51b6fd4c5dbab02e02e4d81abe31f085.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c6e99e51b6fd4c5dbab02e02e4d81abe31f085.1756331945.git.grantpeltier93@gmail.com>

On Wed, Aug 27, 2025 at 05:44:19PM -0500, Grant Peltier wrote:
> Add device type support for raa228244 and raa228246.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Guenter

