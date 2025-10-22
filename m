Return-Path: <linux-kernel+bounces-864413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BCBFABDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C271505C95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76676301009;
	Wed, 22 Oct 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEMP82VW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A02FF151
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120050; cv=none; b=cvCKz5KAlu0txGZukQKVW37MuFG9KdrPAY1RpIiX7arRfS/bBNNa81YxFtCBbxElFwbc7v54RVMN4oF72bpL0dPD/BOLsgYJgIw9P/Fx9n9NS8eu5yDbAcbRWGRZFt/8I825NjsexGdEjHX1BopJl33SjX/L1Msbln/1VdGZQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120050; c=relaxed/simple;
	bh=QBICN3xZ4ilHueEBD5CeEiNoOhGjZ8M4nbBlTjd48Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4ujSKawBzNnV5bKDRS1msuqGkqSs7crjNHrJu3j3KIYj6AAiplhvDwcaTJ7/PKQT2zuGBRtvy4TK4EJKnOyK/5xWJWyirqry4C3Q/25gp+1gb7yP1ISwJs/UBnHmymYKxnQgJBojRl55eGAI/UoErri0KCovju/RuplJzvBhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IEMP82VW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290c2b6a6c2so60803595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761120048; x=1761724848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+A7Bdl6G6fPPOIETkq0bjl/DvdZzVvjHtnPQ5t53Qlc=;
        b=IEMP82VWvTIMAuGjoH8Vscd8iecr/W2v1XNnCA9+xOBS9yShmkMYRENheIF4eOGpsE
         Vrdy+HjWJbozYC1Bz4q2nnNL0gM2mjntr/dGlqW9oX1xTWYASO+9svmdvEpJtZbFYA2r
         xN5zJq8ca0xRnUbs+XUBpFBv0lCiJPxmdh3tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120048; x=1761724848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A7Bdl6G6fPPOIETkq0bjl/DvdZzVvjHtnPQ5t53Qlc=;
        b=UzK7NqI7NZpciIZmaVEcX7yyrpkf9KDaWN12KiVC88EGoPijBvkux9tiKdYVWF/Wui
         ieJ4YysDp52cRK5/U+fOCpVXr87IRFm5BX6tDxYgPo1ZswMScaSoW/GCe3nMhky6PFo+
         rRJ+32gI3H10e/LdilyD7aNixz5w3uzRP/ER7odZiNpC86mruY9dyamwv/kGHoA4uJJP
         UMCRyBvuZuYRbxL6gQo4ydBC4hXq+ttcceCahKjc82eiJFGL0kmzNTFlmS9SlobRdAcF
         bZKaAqeGWwAhIzvWPaMhBEaUiMxZKynUlORd+031vfF8R1FK6r4oPPUwemJ+e4An81pP
         gvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIEIthKf+ju5RWt6yS6DfRZZNlQLQ1THKrQgAEVE3otUxRF/Spm8Xo0fR8nb8OmD7rx+PKz7X5xl1/vm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxDnkXvOaZ7T6fk2gSZPQZUY4gRYCbO1vPjvhCJMyLQ61sApS
	HlAkFt2dR47eDnoRheuaK4EqjftPADABOiqG+tHPXGw+MsYYls/8A/LbL3rwsEZXPQ==
X-Gm-Gg: ASbGncssRUxAl37HEAEztk1iFueRswZTKbKO0sujQ618a4whHyopZ58O2qAklDZ9vtQ
	rCbw2FQnmS4DDBY4GbW9AZdwrEnD0OxO6l9/mwQX/DhYFMtx8GHWkwi4fAeVdgWfWyhQruh3Etx
	46aqeUbBcVuiBHDQux7BJ8CNQh+Fbpma7a+uVTk7XvsJWyPGIeG44tu4r+5upKEOg0+XoK8kUJo
	MkJbNkeCR+u2SUJK8BZIiu00VsazCs5dKfSQ78ZO3k5UXk/DizdoNlFiytMg8Oel/OHoB4IB4iJ
	8qRNf8eFeLEj1H+DApRjmPP+NykAhoR1Ebyo1Dnue5VlEJRXNkvr3E3RrhxloiP2RBXz0U6EGn5
	p06kFYVh600Wa+GNRsDH8hGwHyeWfj8IckVw13fIQ8+jT/ufsW6tvXePcazNffLvUUwY+hkQl/B
	eY2JE=
X-Google-Smtp-Source: AGHT+IFwRfu2UU0x0CKVnA2XXQOjlQ8Lf7ncU2eagOpQerJK/r+6LchvP6koj2zwwU6ovd0NdBRa6g==
X-Received: by 2002:a17:902:f550:b0:275:81ca:2c5 with SMTP id d9443c01a7336-290cba42439mr266990885ad.59.1761120048009;
        Wed, 22 Oct 2025 01:00:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a47:339b:a440:e7b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd8edfsm130602485ad.44.2025.10.22.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:00:47 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:00:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Sergey Senozhatsky' <senozhatsky@chromium.org>, 
	"'Rafael J. Wysocki'" <rafael@kernel.org>, 'Christian Loehle' <christian.loehle@arm.com>, 
	'Linux PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 
	'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>, 'Tomasz Figa' <tfiga@chromium.org>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
Message-ID: <zq6mqdrq2kxmyga2skrizuj63ocbab2o2k3ogeufq3sydmwyuo@epxcrwomkvvp>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
 <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
 <001201dc4297$3903af70$ab0b0e50$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201dc4297$3903af70$ab0b0e50$@telus.net>

On (25/10/21 07:30), Doug Smythies wrote:
> For your system booted with "base" and "revert" do:
> 
> echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

Alright, here are the results:

~ # echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
~ # echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
2300000

Base:		52.5
Revert:		45.5

