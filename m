Return-Path: <linux-kernel+bounces-849658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A9EBD098D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30B03AF99E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A82EFDA2;
	Sun, 12 Oct 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChPztAan"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0922097
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292718; cv=none; b=dBRRQHNBOa+W0rgqZfM9vpgqBMGUPWuTz0MGfnck6lqxYZusVQ18UkpaR++CKb8M4lbRMOBwdCgSrJuVM5t0ybZ8DGHl7Y3hSspip13MAzK/NAJpJhSeAe8ubJz4g9ziS8VBkizjQMbylWeC8CsRDjStHElkzhOrvINxje/N2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292718; c=relaxed/simple;
	bh=/cyhZ/9Hkc7oUmiZm4OS/cSmDuFWOJB6FhmqFyMM3m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmGBJLo3UWYsgo2QuWIQj1isagJVTGuJr2Xm5SP3wMtRxW9p6fk5N1uCNzQKcsEnll9/PMrEB6S8xBdv2a4LEVOyT4Zb00JKZQGN1LrnBDHmfSRsWlERkeby9/6Ck+gVSwoQaFwUfEMs+eaL13fO00RhHOvJnsRDbfxLZ3UK6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChPztAan; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27ee41e0798so57266435ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292716; x=1760897516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Buj0t0IDW+PBuk8/VhMvFLB30ectWj4e/2J77rw3gI=;
        b=ChPztAanfHRIfs/IXcJBQyYD3hqdsyHysvfb0KlnSs1N6dh0OR0goD1+Wk6EoCj73p
         THQp/37Z/WGp3rmOSVSfk7anHCDBGZImuun3oW9OHituNAiTmP0L7pdrNVBtOeABAn94
         7Pc/yYIsZCcKTrh2V1my7jpxeiUKDYt8CfNwSQRRTCfLHmb5hhzkxvtzazmeAowgDhR6
         i8KEtajT/uN1LVdTl1vOvRASiekYIalHsiAeeg3mzZPJgTkhJnKx5ASaDG8UX6e17uFB
         9r5/bcMkkHltRpSDiRdlYUavaz3WS+myzArM/+UuTjJ1OBgWUfgncgytNgYvR+GU5ilM
         2eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292716; x=1760897516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Buj0t0IDW+PBuk8/VhMvFLB30ectWj4e/2J77rw3gI=;
        b=QehkqxTMfeGVB0Wr0pcCy1ePPjWQt1KUoDx8yP80RPoE3YNbUxDITElMIm/T0dtmMm
         Ig5jmnoRP6gu+aA5W8A3ZdJ5t3VpbuvFrxGgR61ioCYSsyOGurqjCaD6/vNdtG14uzNY
         VRsuG1aqxZwbphsW1QgM3ioApTUfs8VvKAJL7s0cRAIlXUcU6jJCn5TYySE14MD2Kbim
         aMWa2GLlWsZ1KEkrOFXs8Id1ZS/j8zMVd9ls1dyBEUGLiPbhFazotljadGZ1zVAAvWl4
         zNUTUmYHRShVW/mnkdIL25hkXO2Pouf1hQghihNiN+9ChcaTiWH/kRZbtbJ1RP0aEsKh
         gPBw==
X-Forwarded-Encrypted: i=1; AJvYcCXe1Avk9ysS2Cj6Ym/cGHqMhR8LTlmdDBfkEqXamDod7DxwtfNkJxXElG9B1f/u63k4uI9GVf43jMD9fmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5C4LLVVbBCbsvkpcU54yvB0feP/Nl3Qvb6oeQqGbLfb7u06vz
	mrKJjdGt73zCfDRCMqydFM2IoEGzF+OlEEwzx3wKZ/YDsVWuSO9Fo/uR
X-Gm-Gg: ASbGncuY/0eZbsSWoPWs+nQiT/wYl53zOye4T6aWH2rfvZppfPmbbemWKdprP3EGwtu
	3KJD3DlFap5hXkiOWIokgs5PU4EN69kIyj1XqjP598cCV83cDEe/ixCnbZi7bi55+v7OMX7QX0A
	I01f4kYlA4HmKCEDkKpBjDRATjcTnGhzVYnzmwvXWrr3p9MmMve9JSB/bJoX10sjG52dsMDYnAg
	BrgwWOfCgVEWJIv0HrVTEvqEjuoik0nAvhc6PhdixxaUorhdTWIkOzLoTet8/t/awcYFDE6FN9v
	KLrbrXF6U1v2Npofg35w3ooo4+wghyjxwm12caQy5tqltN/SwMZBIPoZZm2UZEY4XXicOiRrh7q
	Ir7z9xzlAsijbY2iLlC0HlDLAFR2iwDqC44ASW28ygdO67y5eCe2UJJFfpKJhOThAj9b0evYXd9
	0=
X-Google-Smtp-Source: AGHT+IEcqDTieHsg1AER/qsu+ki9Hdvx/uwZq8AQiPyaTgu9kB1bK40A8LEDTjO5eRccXUF2P/E63w==
X-Received: by 2002:a17:903:247:b0:26a:23c7:68da with SMTP id d9443c01a7336-2902739a818mr222464765ad.25.1760292716317;
        Sun, 12 Oct 2025 11:11:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2905571d68asm45307815ad.2.2025.10.12.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:11:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 11:11:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/3] peci: cpu: add Intel Emerald Rapids support
Message-ID: <aea56786-8cf2-401b-bdd3-0f9733853c7b@roeck-us.net>
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-2-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006215321.5036-2-fr0st61te@gmail.com>

On Tue, Oct 07, 2025 at 12:53:19AM +0300, Ivan Mikhaylov wrote:
> Add support for detection of Intel Emerald Rapids processor based on
> CPU model.
> 
> Emerald Rapids Xeon processors with the model set to
> INTEL_EMERALDRAPIDS_X. The data field for this entry is "emr".
> 
> Tested the patch series with AST2600 BMC with 5S Intel Emerald Rapids
> processors & verified by reading cpu & dimm temperature which matches
> host sensor values from lmsensors.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to hwmon-next.

Thanks,
Guenter

