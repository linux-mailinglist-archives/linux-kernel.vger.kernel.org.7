Return-Path: <linux-kernel+bounces-598668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353DFA84936
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1057A3A9704
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB611EC01B;
	Thu, 10 Apr 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P3aYwNFf"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148F1E2606;
	Thu, 10 Apr 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301164; cv=none; b=cVMlfpuO6O5cM3ZoJQ/aiGAO23O7Wc0FunIgGXuRWGhIKFS+mC4D/AAqoFjqeHnS6AVxAJzH6Z+wYbkOIMILlFPlDvds2/CTe8Yt5N2ZE5iz7NDCWGxF8dcAbpzRU6f7HRmgHpbske36zVC6M6EBeQjgZx43tlS6kKIUCU1bnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301164; c=relaxed/simple;
	bh=RQ31K3VOas79t26Yh2htYFBGQtOkblQk5L9LIpYxYBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2CkRfD+5LJoUv4KNIqXyHPjtwk/x7wWnnHyEhCKFqxgz+a+yHnNF35fJbX3jZFJPKfpw1pt1ubjN5M19nBZmvfsqFyl2/hyqViEFZgUr8EdhvnJDkY6OJby7ySivLFVQXOfALm564k5b+cwSji209LBsptB93cd/JnmWgRgGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=P3aYwNFf; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZYPfM1JHDz9slS;
	Thu, 10 Apr 2025 18:00:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744300811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQ31K3VOas79t26Yh2htYFBGQtOkblQk5L9LIpYxYBI=;
	b=P3aYwNFfYrwBEMTkFf4GdJG4HyiXZpHz62Q69cK9JW9mct+1nqc9MecX1HDi6bOV0QCkfX
	W25pmGnASEsr1jrL8VANqkaF3pnSPt8Kore/trSvxtt+9Cy6u6zMSXWfd5qDbgTT6tSPOI
	MEu/Iq1uAh3ew9VWdDxDxWqHgaTLwEvcPpIzTEpKa1oSKMu4Zx4lHxZRDyV5UGGbXQ+Lu6
	3dASOxLlMzm8GAQRzIHOabChwX9lFvvkj0oL8SaUQ0OlomUqAflfrOXa8hCRXl/fo1fNFc
	1aru9OWnbrQVru2P/6GryHQVnllEH6qJ+wcT3WQr5hnljL+rLKojg2G0g8w80g==
Date: Thu, 10 Apr 2025 18:00:04 +0200
From: Anthony Ruhier <aruhier@mailbox.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Maya Matuszczyk <maccraft123mc@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/7] Support for GPU ACD feature on Adreno X1-85
Message-ID: <iss7n7svaqmiwx73wczw66zrpx5eoj33qd37iuyvwkve7f6lw2@yyeuhridyn6f>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
X-MBO-RS-META: m9cmpour4giseu64pbxuzsamkynzfwty
X-MBO-RS-ID: aa9fad2c6d8b94bac65

Hi,

Tested-by: Anthony Ruhier <aruhier@mailbox.org>

--
Anthony Ruhier

