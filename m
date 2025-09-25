Return-Path: <linux-kernel+bounces-833033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE73BA10BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DCE7B5CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642131A045;
	Thu, 25 Sep 2025 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9y6B6jq"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32731A04D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825437; cv=none; b=pgeHSzoZZ5IJSWMRpObAWbrOoTH8xgtZAufZWNuLC8pRw9XS+IL8M71xhUTdwNB92vxRLzL1BYnwVWak0dX0+Rx7ayZJeOJPMpq6gVHz7yMlOY5RH7A0ivp7++lmZbiJQqJj8RMbX2lc752cfVUjhYRu4yjvj1SXZLiF+qLKIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825437; c=relaxed/simple;
	bh=0Q1cTjmZ9Hi0vHDbIbYb1a3iXAlzjO74mKnKxout+90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR+ChbG3j2Jo+pEEQ7ICCoGa/PTb5wDVkSlvPfXqUI2VpzIciCzWF64gNPvgC/7foFuEeEVlQLa5setw+7dxycXxXYaVJVbIQoSr58axQ/iRtlooFNiXcm6eaHQb6JHXr/Ctu3x8MTnGIDFV0ZxJcHOTKpGndKXXk6GQ27yU8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9y6B6jq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1216138a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825435; x=1759430235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejaK95uuDfPzMcPS0W0hlWY6j8PK1ad5B7aVSF1ED4s=;
        b=V9y6B6jqC/iT0CaRu+9dT91/aK5IDDWeZ5A7TkgDpekpUrQ/PEM0AJQUjqn1Tr0zgo
         EFa8/MD/PBLiEzEPsw2afoMMZFdhbTa7bvSBu1SzEdsDEYeKJNwn30QPzxKUx4e11cjk
         44Q1ieR9GJam2ZlgPPQnbxNgo0RuL1JNLYyrI5UFWjs7OEZK5QfXqulMDuL77njA0EmT
         U9txg5Hh8OkVxu1fL1QLSmNfrApk94/UqMc0jMbYV7nZ86PsjeLOSMZfW7VUSQY7HFQ0
         jiWq31Dl06pYJT0QSrL9gVLwlXCSO3b6f3Etuxc9ptiPzYE2TYcMWfuYF8bzNO6R73VM
         Ib7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825435; x=1759430235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejaK95uuDfPzMcPS0W0hlWY6j8PK1ad5B7aVSF1ED4s=;
        b=RoAxokSB1Mc287PamdyND5Lx3pMZUzPErBo8/5AOiTKANdmOqk8F1+rvqtr51iiUSX
         wd+bk1cHhJppOdBUvxE17qnYVIUO/iXfCi9tk31UKv4hN7fL07GV2jqYy/9IRv7jUMeB
         /k+P3gQTrRJNSHsr3WQHMBTtV1Yg9o7bG/eR4m+EA41h6LPlM+cjP0yN6fDeEYyppO3q
         QIKrXqsHLWlfrHFuwFMSx1Nr3mLBVHlR9YP2Y73Eui/Q0TGHLMtYW5qPYKZ2acROELaw
         IL9B2YFMQIrbXA8yK2ZIuehDy5qtst1oSsaBP/FUrRivtJOJl9p00qzJC7pyjNGibvMc
         fMwA==
X-Gm-Message-State: AOJu0YzbYAxUlOiK3MfHMckHJ9Ui4jB2QrSHQ9MN0QDbguXdA4l9v2TQ
	Ti0J3hDgc4f589FSz0er9q9Z/oub4Q5NNBzqorJPVdv9PE2+hazVmzvPJSeMgw==
X-Gm-Gg: ASbGncsEszpictzMtq4WnC/Z+u2+psM7Gw3HZuhsx/xsUPyejqnJl2ylM59sBBitVph
	3h4iNH60aPHj+x9Xz6Fk+vGWfi2zN4Y5E8mP1Hs1mcnEdeQeF7xPccqBUzfwWvXAIWjo+UaQltY
	4uqvovCRqPGA+h1676anYu4CO6QrWJBKQm68pV60KEdyIrHt7daMoxlB7/DJLwPf09VS31u0omn
	2bPhVirmmrmbSPNIoixSjTBYxa74pkrxfagBWfaCDL4Hd6Trn7j3uR16xiRPtixBc10Tk2zk7xi
	jX+CcflyBsOzHjQhJA8IfLbFrgWyPG5pw7jJ6Tq5C0WqCtZN94s9olwGEEjRirUH04doLdj2lME
	nz4aS5F5COo7Xdshw1aMbcQ==
X-Google-Smtp-Source: AGHT+IFQ9L/9odSQ7gc7JHhUpQDD9t7I9o/+eSPX3b49TgfFSepGgPL/WvhMnEIO2E2EA+RGSnCEpQ==
X-Received: by 2002:a17:90b:4a42:b0:32b:dfdb:b27f with SMTP id 98e67ed59e1d1-3342a2bede7mr5384154a91.17.1758825435565;
        Thu, 25 Sep 2025 11:37:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5a97:14cb:a5e:6c78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be383b4sm6480831a91.27.2025.09.25.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:37:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:37:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, sebastian.reichel@collabora.com, 
	linux-amarula@amarulasolutions.com, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [linux-next PATCH v8 1/3] dt-bindings: touchscreen: convert eeti
 bindings to json schema
Message-ID: <knegehuffheb3sxbo2vu567wnv4htomsvkqnw7b7skwtiru5tw@7rwf6vrwrppx>
References: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>

On Thu, Sep 25, 2025 at 05:31:33PM +0200, Dario Binacchi wrote:
> Convert EETI touchscreen controller device tree binding to json-schema.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied the lot, thank you.

-- 
Dmitry

