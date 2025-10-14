Return-Path: <linux-kernel+bounces-853313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18016BDB3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476363BD91B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEDB3064B5;
	Tue, 14 Oct 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6J0Klkn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9930597F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473291; cv=none; b=R3EA+tZJ/nnb+SJMB3aNAuRzu7Wj6yyJvR6rmBuk3tJL4reAwKhhrkIFAspqQCPqD+PYfnBqrBi5Pr+L8zTnqDCaSc1amHbu9U3EIvxR65w57Pjlxe36WtWgtGwXg6Q2rjskmg9gLhb5hfYshDmQ/7kSSHIjflhNpE/lIujp6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473291; c=relaxed/simple;
	bh=sGslfGcS1WTOAxh3VGsce9A+i02zHKcOz9kv9uZ8VA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTdUwckejP8KxAtsQEawntXdQVOrGOjRKwn2L+Sz3y89GwUQN/JsBWlSCWgbM7ebw6La1XaJSQgRb31hEwPvLnFXfn8ouQvqUy2/f782WF1IumgEpP4s0G958Y2NUD64y15hMpVTWda2WyZbhSktBv00R4gPtP8W1r+0eP5Sr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6J0Klkn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e38c21fafso10731395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473288; x=1761078088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+iQxMhxf3KTuC5cfF4X7qeWhAMoIsr4rci9ih9ZP2k=;
        b=Q6J0KlknoRrk4pn8ybJs7DaukobHkINq8tM8qHIFahdboCkAGDL30Wf6UmzgeOrkyO
         /KMhxTBpDUHr7aKzYEafc0kKHMXvV1D7cpVezsLbEsDJC6C+gURLN2Wl3/1JDSsuqiMK
         5TyXnclDVUZWwoHsbrfN/vVD0D0vm/jwjdYqh4M86pMKfd7XQD1fTdKW+gGjZolwj2Js
         A9q+N+OG0Ke6sf6Y0pOb+DEXf4QSUiPHyfMmOPzHhi7dPZFN9ydnfp4mgvNStwxwOTXX
         e8+0tOiXxat+xBHjGvlZ0v9oDzjjGjdyI9k60AYOmzludpxHLwXkBdi43XdtPeevXFie
         J+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473288; x=1761078088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+iQxMhxf3KTuC5cfF4X7qeWhAMoIsr4rci9ih9ZP2k=;
        b=n55hlcubn+7zRZVfxTNbQG1tc4FsTPh+NGFVatHkClQdg+KJ6lRamYcO97CbpzCqg2
         93WS/n5CJPwr+Wd7twod4IJAH4PJBhu0Jvs1JYurqKYk4bVpIrnb/j9rI8OkLOMSMa4m
         1BQpxZRT88Afnj2+e/Ku3rd9Vza+xcy0o3XlbcdSAkZe9X2XHY5qqZeyqI1Cr4eSQSdD
         XWhg5y1GqczrdXCKw8LujreYlBUlaUBVGSJjpl+ju69wQERgEFtAxpr5zfAbFdlNiaKV
         ljQKkJVtjfrnnZ5r7A71O4KXz0mqTMGOw32uqVRvUTyAWgol1jBACNpXQwToksuh83rs
         jq/g==
X-Forwarded-Encrypted: i=1; AJvYcCUQsQ3VLyXJ6mmRWpcoP8PuJyvQfCuZqxXxxKm3HLo/JnjDLnhtDULfCr+tUauhe1nhI3FmomnveFsQxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaardojXIp2uN/eO9L4I0rWtTybxjms/DxVjWww3cP5N80qln
	Sd9uKIpNbEjfm+1i9I5xQ7bQKwyKRLp9QvPiazNNlUPUgRCwrw70C4xn
X-Gm-Gg: ASbGnct5eHHMWktR0bO6CnPVDRdsLiJF62cmLpqzBQW6lyZtMm1A9hLWW24uIHZeSHM
	CjPkS3bdhOsOqhbJVeT5TfLQ+lj8rXd97a5wvldbpr9WMVqvrNq9eLsfQf6Ryg98tVjfyxuqUoE
	rrsBK4YWui8tE/dh7Fe1opZL0Mnfnmp99/8OP+3ndaIW3XnpaOsrR5/DlaTu8qldZDKKJs29amV
	cU9Ef7wcwlg9KIRdTtq5gh++UX44tsOSea9qT4r5kn3EWaXiBC9G8gtUvvIDIhJKAmxEAc9cr21
	BLDQNWkjDWPYrkIXEIgGjPa18qlMI9ymyKuTtYKQRrbSFIM70F6LbFG73clSivHr53eNa6zHaW3
	iMgrZRlLlm4GYVY7DBf1l8sXhRV3bWSqLmQ==
X-Google-Smtp-Source: AGHT+IGVXsN12LL6zIzUriOIRUUIRdjw8rYNtubtuh4fULjqJ2hKOcLK1N7+iwDggpPOmnu4aKu4cw==
X-Received: by 2002:a05:600c:4452:b0:46b:938b:6897 with SMTP id 5b1f17b1804b1-470fc9f0bf4mr2120705e9.1.1760473287765;
        Tue, 14 Oct 2025 13:21:27 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:eb00:dc9d:6aef:3136:d6c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm25958870f8f.23.2025.10.14.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:21:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:21:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: b53: implement port isolation support
Message-ID: <20251014202124.wrlh773j6aebr4vm@skbuf>
References: <20251013152834.100169-1-jonas.gorski@gmail.com>
 <20251013152834.100169-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013152834.100169-1-jonas.gorski@gmail.com>
 <20251013152834.100169-1-jonas.gorski@gmail.com>

On Mon, Oct 13, 2025 at 05:28:34PM +0200, Jonas Gorski wrote:
> Implement port isolation support via the Protected Ports register.
> 
> Protected ports can only communicate with unprotected ports, but not
> with each other, matching the expected behaviour of isolated ports.
> 
> Tested on BCM963268BU.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

