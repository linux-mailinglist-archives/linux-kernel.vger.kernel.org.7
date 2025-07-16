Return-Path: <linux-kernel+bounces-733737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE7B0786A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1575D1777F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1E233148;
	Wed, 16 Jul 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5bajgKQ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E15262FD9;
	Wed, 16 Jul 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677105; cv=none; b=SmQ3Ob9lt3IaXZLOxYSSyBWEu38g+n2GpZ325CMC//gsMjH5lAue5LbYtYM42CHjtT/zosjoVXH/+F0I3PuveavqJilEb1zZ5m7HOlOQrDEXKFmivrhpFXX41keJDfl8gJqsgSqDzim9/m1c9KLXyrEemn8s1wDWNrdOeNMhtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677105; c=relaxed/simple;
	bh=wyuvKrtRG5oGtepWadbvbTNvnCaqbMYf5DpqMqaqlh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se8joIOg1UBG/QV6qRZYrPVZ5JzWlORL+CQQxaqwtrSgMS2fLWrvLt9iG+eWNr+b/aoXQvFLFJoCyO0P7VPeDyWDzyPsQncJkRdeN/fwyU8AaEq4A4SFscC9AgBtHWSyaItMFITk5nFrIuAYiDKSNZ+6zRoBKAw4ruInM/poXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5bajgKQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b271f3ae786so5068393a12.3;
        Wed, 16 Jul 2025 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677103; x=1753281903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1PZhsBH7rumWPcw2WhFRzlq6BRydpWFSBH41dMhMRg=;
        b=j5bajgKQ5NRg45wmUUcaiyCz1H219WI0OUbz71kByjUOeod5Mk80eeLh2WUV0edjQh
         IdUaVwqc5rpfIJDnN25/RZ3qaythhspEVvP5U6RY2DKAo14eJ52/LeqwKeJeh7GG2gWD
         un44wq6u9y5q5hnqGI0sgtNVssVkBMaRSkZoCMl1QcMSJarQgTR15KKiEtgdPsu+sGpM
         nf07bK7lpHLiGZyfvw4m6Dl/R+bF25u81Y5LZZfC54/TEsfVmvUk+cmZ19+eY1S2Z7Y+
         Dm8QI52eFiw684TW/9e2BN87Cy/J3si5luHzBvakAdhOvC/F6jZP8wCzzIr4znlIMiXP
         TMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677103; x=1753281903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1PZhsBH7rumWPcw2WhFRzlq6BRydpWFSBH41dMhMRg=;
        b=v+1lTYmmzlL0VmTP+imcVJ6/qAkZ1geMpcYwJNJzB+1qLEqz1aY4DbJE6rtKalHNxW
         lAcSdVSctZS32vSGUJI9jIbmnYCe1ORBQaldJJE6+FPQD3BteiKjctEO7I/+jl9TlEnR
         hBpJXX1I4fTPGx0CV9pypS3y3hAcc6In4XFYfWmpLbBCcav2x2XHQG9M4WHOG29eyklo
         pV7RRJE6ArXKDSpiIY+RZWhtmkNg29qvMiNz/SKOMnk6fcXDcrSp8E7v33P1v0abncGz
         iF+sce1Qp6CzOlCqjnxnMvP6UlUmComU5wsCxZ/UvIXo8GCYhYggN2Znza1MQQnTVvt/
         Sv0w==
X-Forwarded-Encrypted: i=1; AJvYcCWd8nrOGkeAfVtDFGsxAbtrTyj+3MLmnw7otJYX5Dj87jgb+gTkuGmePekVK3/uBf1NDy+Lyu2zuTMN@vger.kernel.org, AJvYcCXZYPelyXfJZ6OpZ8IGvBrzi3bwnUg1v1DnImM4iJPAdhOZAFGp/c+XJb+0ArPhEFU0NJHLqsQ/q1X7rh8=@vger.kernel.org, AJvYcCXpYUgd4+He7P7CDRkWSFxMqEKn0WPt3Ds1ae8cYuAjFhMpeq5oVhFyk9kxHzCWtLNNfK8H1JLvSis/knA2@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+ht8CiWIcjoQMZlKMnxIq+aLKjSSAHXEytlZB1R43lrZnNzL
	Bbsc4TkymOLmhvfHoisqZGzMdzXOv6po3AiZhoeG1/01Ei7ZsOZLTXoV
X-Gm-Gg: ASbGncs4gggTg+4X1acxmrgSgwhb84KIwsp8MKi8K9NsWwnhElVlqHcnc0vFSrq6ea4
	PhkTPbLM78/JC2ESLLjndiYeEIi4sGSx4N0To/D5q3gQJSjzb578XgZBNgzocvKRch40RfM7Rp/
	Gw3Bw/OngpaczY1TGQA5IPr1y2xjTN9ltLrLDgLeFdqQM1ZusbOqnzZyaPe/kcp3TfjsxtoClY0
	BYFhgVEhYWxrR8M7OuMT5yZfSoTyclvbI0Evjy9pBSKL74sem9hIlab+dagflXX4HFmYTxtclp/
	6oCPsRzHlsl4MONHB7liLdzhxWiYy22gna+3KJ/QgkzP7WghSPuRPVbp60Q8i/+d6FDtmRSPdy7
	uKG4ejQrGfY/SlYvarcUAnlI2znppB9FL/6k=
X-Google-Smtp-Source: AGHT+IFvCABoyRqh28ft7DIK1ux04BJVhVzabIMT3bLRNfCyU/6bwGhAaKsPW8KeWyN8S/LWKfDE/Q==
X-Received: by 2002:a17:903:2f08:b0:234:c8f6:1b11 with SMTP id d9443c01a7336-23e24fe944fmr50224615ad.44.1752677102843;
        Wed, 16 Jul 2025 07:45:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428b06bsm125121665ad.41.2025.07.16.07.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:45:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:45:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jim Wright <wrightj@linux.vnet.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: trivial-devices: Add undocumented hwmon
 devices
Message-ID: <08792ba8-55bb-4190-8f33-133969a261da@roeck-us.net>
References: <20250701-dt-hwmon-compatibles-v1-0-ad99e65cf11b@kernel.org>
 <20250701-dt-hwmon-compatibles-v1-6-ad99e65cf11b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-dt-hwmon-compatibles-v1-6-ad99e65cf11b@kernel.org>

On Tue, Jul 01, 2025 at 04:00:45PM -0500, Rob Herring (Arm) wrote:
> There's a bunch of undocumented, but already in use trivial hwmon
> devices. Most are just variants of existing trivial devices.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

