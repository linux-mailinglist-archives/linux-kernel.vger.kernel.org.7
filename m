Return-Path: <linux-kernel+bounces-852962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD87BDA585
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 343EB502AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB492BF009;
	Tue, 14 Oct 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwFrN2YG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C52C027A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455126; cv=none; b=pFDo8kkIzj0Lr37T+jTUt+cmX2yf4DOL0gFfFBJVm339dNmVNL0eIKHEUs0hS/Ou4RaD5ZjalKSack/NUP+eA/pnq5p2hAr1cSbfPVjWfo+85cBH/7Mrvj77nr/cNg+1gVmHZGN9OxWGVRuhTVwMpo5Y+AGwnQn9HmFrthrDvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455126; c=relaxed/simple;
	bh=JC60HEInNluqzF3bnchV7EOp617mC62c6zir/e0gnlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPmoe2q12vaXS7o6wpQrb3ULAMsOKLuVmMA4KI34ukfu7SfYryemOfUSIi1KP2SipgUGg/1DjKEWIi6bUpucVT4Ll9YM5AVJyl5QUbyLZRNY1mL4TH3k7rPZoEBR9l5kS8Un/ovG/OUhgQijzUuwRppB80lL/uDZWVTn/dhvlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwFrN2YG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e0798so87608365ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760455124; x=1761059924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RG2muNaSakDWxI94gPRyAVmL2U1gaeN0a3vQP8Zu5U=;
        b=UwFrN2YGIv3vI5HCIqsNtILexdt139q6LdscQO/XGkyIPzkkZMwu2pie4wRdr9FvQC
         2OwsmvlgG0/wLVlq4PEdF7/jVE3llgJc56KR9H7D1VyCytivjE9hM4gbSb74YnbH/h2H
         OUQ6ENszTnII05N6TeEmS+f3N7SQpBkjRIY22r4cjc5rmnUbMZuVG6AGNGn7pX8mMNwE
         yCMEGRRaIcMpGTwxWVhS8d/thUB1nPjpotGuiZgnr8tXRRq6MuwA7dDl858exBOjM5MC
         r/zzZjEhhIOTlP2l8LdlAcmwg8YQizEsC8MQtvttoB1uKNol6qsMSvXHdNPjzu9mT0g6
         2TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455124; x=1761059924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RG2muNaSakDWxI94gPRyAVmL2U1gaeN0a3vQP8Zu5U=;
        b=QgtlDcNPDIAQzGHCAID8d8ZNhGDm3AaA/c28EvzTie71s/fxn17G2wTwItQJ75W/ei
         MVdfauiXtS8xuV5QAwaGrTtWZGPrc6Squ0OktT0ICZpHZ4D533pjFd9sx1ZPjCGbdh+h
         JvbXOlT499q0B7pbeUQ5Uu1R6BIgDp+NEJsR6LX4hRl645H5Nb7p/kd2F4hKIh9BHYAe
         QqwvEeHzP1eYIDrj+kosm00K0Sgktrj7LAfvIuzpbIFJiGxiF/G2XStwKzU3aNl4kw1D
         hFSy14zn7m8pzgcFaEZJVlMK0BO50ssEJAlAJNx5dOt9eU/AgSeSPUh6u+xNwJniybnm
         +kDw==
X-Forwarded-Encrypted: i=1; AJvYcCXjrpMLgU4Lrfid64XTJycAV4M7WV2AF0jdRSeIVPpxC8tRKfGsacc/rnK1m/Lpcn78HBpZG8v4dim3Wgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthpxL6Bo7DC7fhE1Xtn4GgWHWClGGE/WqFLY1Vd4Vb9MSvePY
	ms+18kggzxTOA+6ZurC2D6oyCD+fzRwVn63rQtpvQoD1wXiMxMNnc7DvAR66kQ==
X-Gm-Gg: ASbGncv+5vzxFiKVKJ95Kp8EyoLFeM08FyOScRZc2yXqIuSodWS7QCDIbti8Mci1W0f
	8V7ooC02UCPLosJrrnGhYLd5UI+ydaKvoZnss1qsRpgeV/mFZr25e2diY9a5ULkzJVwDJnDqnxH
	xAoikvgmoV+4WqdIXD+5RS6jGJJnhj7AUXjsDmYPRrUyoov1lYaNvxT12Djemkte9hTHB4zTSya
	mTosgBQchdCPXzaZWtKO0828eU7J0Mye/7u/HcpQIEtVtf3tP4nBiYlshNF0Puw6Umsrb27I4rm
	8WohhU8p8cKKouCqjyM/vri75EpT0lesrZzNIyBvytnbh6GXQIdP8vPJKoxp/hEV0oiS5OqACPL
	Q/W+GKmB2ASW88dBNA9hPOnI2IVnPAS7DsFRFbKf2FyQ4ScnpfAppn6FRiMiOE3hX
X-Google-Smtp-Source: AGHT+IHIsEd1SylS40HYfaucznmGO/M9RGsNWRga99P+rm4jbrckX5mvU1P7jlaSDBhOyjB7a0ocng==
X-Received: by 2002:a17:903:2ac3:b0:281:613:844b with SMTP id d9443c01a7336-29027418ecdmr315810205ad.52.1760455123527;
        Tue, 14 Oct 2025 08:18:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc53sm167544325ad.46.2025.10.14.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:18:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 14 Oct 2025 08:18:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus) add driver for MPS MP9945
Message-ID: <7df1419e-18a1-4656-aba0-2f82914bcfc8@roeck-us.net>
References: <20251009205458.396368-1-chou.cosmo@gmail.com>
 <20251009205458.396368-2-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009205458.396368-2-chou.cosmo@gmail.com>

On Fri, Oct 10, 2025 at 04:54:58AM +0800, Cosmo Chou wrote:
> Add support for mp9945 device from Monolithic Power Systems, Inc.
> (MPS) vendor. This is a single phase digital step down converter.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Applied.

Thanks,
Guenter

