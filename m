Return-Path: <linux-kernel+bounces-852554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25A1BD9506
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCFD1925925
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156B313551;
	Tue, 14 Oct 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU7O+Xik"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D2313532
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444550; cv=none; b=SYRL2nHkpSagZYIOI0DoYlvshmKbTouYOdToHq+zu9q7qFLVovl2FOkR4gIt0AIVkOHwTfk3WfFJuq6Q/qRQxIcw0TEkGc1Ypw2GmOj9q+xTyv14LUId9U3aAg++mqmNLVvBCMWMHCwpfGRsEg7FPHNz+veN0bisYLfJk+ucxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444550; c=relaxed/simple;
	bh=Ad+Act/vyc65p5SZBMOE8fQZgfdis66PnpmCEaRCJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENHxAcA55B8RAk0Vd5jyWESB7tn4/EDiIg/c2GmymSghJ1XcM0S2KyoSqJiimQdhYY14ETVtONz5+Vf2xtm6/pAtDqkI/nVWqlk3jpr9koZUOd0WbYZ1YJimwDeB+DRr1uwa2JECvWOMCOVR0JbBtrcL0c7ycnK4myuTB/bcVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU7O+Xik; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso1801076a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444547; x=1761049347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad+Act/vyc65p5SZBMOE8fQZgfdis66PnpmCEaRCJyk=;
        b=FU7O+XikGsec1PS6KeGLNPMk8QlwqA72Xfw5vrgURwaq+eIHka2r4ZZblcaUPKHEyI
         2OX7wf2FVSevdlfFpmxB+UiQOKSZZkahhAWlqOHaitOsoLSxGWq5Qeas0Zkfh/ipIVcV
         +fU5hcufMlqXE0uIPB2UvySzZeey9M14FMAxOUvbo/9jRnyUex1PaflBtvo6cgMcNhH+
         wdZCOunamSR8O2Ue+PTwF7vvUgflfP4d97uExDnbw8lTZoTypaKpZExL6zOoZBRsU3bt
         L+G1/qmgDZy8yRmkUCKXLrL3/f7wmMOWqvH1EpHRnAG4pKI7y/95R8c929vwMkfQtE5t
         kTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444547; x=1761049347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad+Act/vyc65p5SZBMOE8fQZgfdis66PnpmCEaRCJyk=;
        b=m8F0l1VGl7HE7LKuH29Q81IgXaJ1PvzOJvRh+Jdp8LTWHyZZI9rfNoUSFbcQa4K6uM
         Y9XOseynlrCwA0vmVJSAYxp/zPlnY+y1zQnwC3MdWmEFPhk6RL1P+G9C2mu9xLBYJQRa
         3wvNyR9ADJVFI7qDzs0VWGvOblXfw70k1+Fe4+Y4fx1DxHJxANev7FbGXl5wPeNnYRnf
         Uprqgu1F7o924OacteXgzjwn71eiTyWLk8LDDsznFQeUcjHzPpYSedVJKqm8gijI8Gik
         9LfGPyO8mHT1fZfjxxEPK6rJ128ClNply3P+RfayygZ58RejtKhgBMphReaVLjLTiNS7
         bQiw==
X-Forwarded-Encrypted: i=1; AJvYcCUw+nThYFWsJJhNVcIFQl2gqthfEAEjwbxWVPcO0WynbOVPCWyLH4z3sEHt/X7r9tkT0R+mv2V5cHW5w3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5pHn6YM39cnLCgBvjZU9+0yGnLwczaJmKFUaZB0FzR/H5BfZ
	FY8kybHPHA36Z8fLvG7JnFkZ7gcc/D4ucqoMJ2YLb82HmppZMN3jngQN
X-Gm-Gg: ASbGncte4QwEPK5LrCFUWLvMOnvhWTPcLKDnijCzbx2BBEhvtS0u/aoIv1RUS48D1pA
	Q80RV5LgyipDNGkhoOssTYh71PpsZj1E7JuSZDF464A5AuOHv+5O3LDubzI0mWFVyft6pOeFI1t
	BI5koCaO940i9gCzhuJmFaowV1qMadFaya3d994YMTXDPP9s0sXLdG80VtZja1ugRV37zEDjphL
	M3dNHcDHBlXZwbR6ovUbR+egvybaAZCRtK54aT9515V0J8buOP1Z9BieidjJX0H4Gb2LcUAL/X4
	Td24ZyZoAmwjNlSQtsKEbZ4W+jltEiZTQ32Nf4oPE2bQ7w+RrTlVg94SVVXX8GJhx69vuz7Ls4Y
	SnLRfe/D4rgl2OU4dkqn5ts9RMbkQoL9zsc0LlZ1a1Kj2yahmyVNIx0dScYv60riM5mLdLlPXwE
	1KAcjaO7upKLO7XcBjWW0v/B3QcLNmnGrwBfy2vmhPl2Hf1TlK1Uw=
X-Google-Smtp-Source: AGHT+IEj2JtS1ykV7+4SnCPxXcV5s4F2p8zZ4Ybts8U4kG/OqGnxgxiwp/Y8Fv2A2MsHbr+lECLEwQ==
X-Received: by 2002:a05:6402:d0e:b0:634:5381:530b with SMTP id 4fb4d7f45d1cf-639d5b8956cmr22376195a12.13.1760444547186;
        Tue, 14 Oct 2025 05:22:27 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f358sm10963835a12.10.2025.10.14.05.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:22:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:22:25 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] drm/panel/panel-simple v6.17 WARNING regression
Message-ID: <tguubjlh7ta7rvaq5pzzksamnc2kxy6yunsk3jeiiqz55on4yo@outv5vc3b2vl>
References: <hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r223ar3txri@3ik53xw5idyh>
 <DDHZ5GO9MPF0.CGYTVBI74FOZ@bootlin.com>
 <kcunz2b2usmvadgrnnu65op5oi5ttblrc463twgxp5gqhnufav@eze53y23avel>
 <DDI0OEMAGBI3.2WFIP0O7M73LB@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDI0OEMAGBI3.2WFIP0O7M73LB@bootlin.com>

On Tue, Oct 14, 2025 at 01:43:21PM +0200, Luca Ceresoli wrote:
> Alright. Let me know whether the series I've sent fixes 0, 1 or both
> warnings.

Hi Luca,

Just replying to have the info in this thread as well, the series fixed
all warnings I saw, thanks!

Kind regards,
Ernest

