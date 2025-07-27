Return-Path: <linux-kernel+bounces-747110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9A3B12FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E454C18979A5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03A2185B8;
	Sun, 27 Jul 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCUHiezs"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBB1DAC95;
	Sun, 27 Jul 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753625241; cv=none; b=A4UfQ1QwaYuhBKprvlJBED75OQot7YOsmc3FGUOWkKQvjJTPT+spUB7/CV4I1a+Vo+QU/Ko3OYz854iHO+i4MVD0i/2ULOp0o3v7Q0GCqVcsU68+6p8z8kTgsszBPhUsT2KQnj85IPErBAhULLe7kNf0FwO+Z9gZ6EI8ep3ruso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753625241; c=relaxed/simple;
	bh=0NRnrtvx5Nd0mZa/d0TTBJ+mm3Pv6a451mcqUAxzMRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMmhDdIH+GY1qK80SicfH5Vwq33H9pHMltLx1TG/us+p13lY+SB64Jd2FXbk3IZ2mJRHU2t7XkaxZ0FzXsfmk6eptgWkijyrS6UT6MAIwtTfmyVJRiT2gs0Hbrb+5du44uHoM2jdSHrKEOIYPDUJjLVwKbtw+yCRXeBOLQGlWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCUHiezs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so2947943a12.3;
        Sun, 27 Jul 2025 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753625239; x=1754230039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijMatxPTKApiZUPbghgjR/zDx2AP3DuF//yAnK8PVuk=;
        b=fCUHiezsJo1pfQXXV3CiWQZPJtAFVS2LAzIjjPCAbuv/wXf29hNPm6KWFCHbnDTNGY
         Y8+Rm2LZp2vZleqX3PUttGb9rdu71Ox7rouV3SxlAK5/Rd0uKhKVmT19bi2xhQjjY6+l
         ytWAx8x9nF3LM05HGT3z6kWODR3kOqw6XuQFgXKoGfYKUxbv6sKqRREh3I+tTzuIt8pb
         /nr8u8rw/lCytEERmgwXkSgMcuHdL6rNC9glkux3qolQ9jk/X87zQIoi/SrM1JfR9tj6
         bACEP22nVzF0Pjd3Sau/HXcocNG2kYsa0BD1gT6+5aRqkSbq/WGz/PXIWwox+5xCm/wk
         xu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753625239; x=1754230039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijMatxPTKApiZUPbghgjR/zDx2AP3DuF//yAnK8PVuk=;
        b=wmRpC8WQorttbY8FngFXSyOQnnUidetJM4xvWOaonUMd28sd1siYnNnwjUhWlKh2Qp
         0XVfY7IDsUjWd11rT5JBpz1NwI5VTo3X5Qrlq/5dlRnhscMKjCZ3Ii8K3xx4JZgjewOa
         MjjeWG+NltZH4pcT7H9qo9BNzel3PFCEWPixs+B+t8xD6R35Hgr+jqMpyT0PqAPj52mZ
         i8EK+HbH4616vD82GDwEXJjiEPDfrclWgLCYg8AFzIx1eQbB8+5+Z2PtDKC2h2tiiK/4
         ohx7QU8/N0MuHcWM9LzN1/O6d7QWZ3VoM44bBNCug+x8Uet/z/5NyaV2B2IwIuq/Uu4d
         WAEg==
X-Forwarded-Encrypted: i=1; AJvYcCU0dCVoKhn1I4Vze/YlDMFtZNjuKtskeaWJlCTBAaM0VOPO8SS17SqQaxbT9DmOw0HU9UfWtsZYyrIh@vger.kernel.org, AJvYcCUk9wFYSmrdv5GLHsknpVYIVwxumTDnRx3PUg8m3ZYEPca4rvpoihmb32DKDkuxtiaIX6zU6OC5IAgbUOo=@vger.kernel.org, AJvYcCVm965mZpFp36mWqg154xjDyxSUlKIKvfbu4mmBP+oQpdwWAcac1th7GIAGbmr+RA+Gytak2qe5/QYQJqI2@vger.kernel.org
X-Gm-Message-State: AOJu0YzHeueZ5syiGuWjveyGm9g8S2e6maTISQRnzfZdlxkzENKTIt6K
	grROrSkSoh+H+wvOPOq5wrdZ3F6FwV0bR3eOldNGaIQfakLngV9wyijY47EBgQ==
X-Gm-Gg: ASbGnctVa4omae8VlJBoIeRKJGZithT5U6Nqf6KXEmrRINhvZsi+kFxwHiMCAC4NQUy
	rwXY49iQ1n0jSBHILwQF7rtE/EmtLuJj/XEG4tvrLXUWMeOeM1VnhKY3U8IAnO4jIvNyo+KZplk
	hkoSO1z2vm0Pq2Z7XELbS+F2+1nt6TIp5XWAyQoQXwkM/GV1ZYAKyoLHRs53S3/2eASsDP8E/iy
	cjeU9u5QTkNi5ova3cfHo0ZTImwleuy2phcjsrt6DXZ/nCt0mG7ZqBux1kt9hSyMXaIfSMppSy+
	kjFO6d9+zUX9xgaBAil91z3zqiNWoIh731O/2hIFeD4fwMdRO3C/+d4h28LusuZrFvOepAI/f3o
	2/bl1Zwe//LI5JFeQzCqxta2s26S+qopb2lI=
X-Google-Smtp-Source: AGHT+IEQHs087lj02YqE9M+XbKDd29RwR3fK0vwhvrdjnhXjWGjxDg4OPYYE122c2ldL1inh9RBClg==
X-Received: by 2002:a17:90b:35cb:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-31e7785efe2mr13853465a91.11.1753625238202;
        Sun, 27 Jul 2025 07:07:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ef172abe3sm191490a91.39.2025.07.27.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 07:07:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 27 Jul 2025 07:07:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cedric Encarnacion <cedricjustine.encarnacion@analog.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Replace bouncing Alexandru Tachici
 emails
Message-ID: <b0ff5a5d-f397-42a5-83c9-1b0ba8b40dd7@roeck-us.net>
References: <20250724113735.59148-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724113735.59148-2-krzysztof.kozlowski@linaro.org>

On Thu, Jul 24, 2025 at 01:37:36PM +0200, Krzysztof Kozlowski wrote:
> Emails to alexandru.tachici@analog.com bounce permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace him with Cedric Encarnacion from Analog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> 
> I don't know who from Analog should maintain these devices, so I chosen
> author from Analog of one of last commits.
> 
> Cedric Encarnacion, could you confirm that you are okay (or not) with this?
> ---

Applied. If there is a better maintainer, lets update it again later.

Thanks,
Guenter

