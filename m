Return-Path: <linux-kernel+bounces-887179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24230C37777
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E1774EE3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32D33CEB2;
	Wed,  5 Nov 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOvPxOeW"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81486279DCD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370647; cv=none; b=OsaVvKF/+j5EU3dlOpmla0WklgnFrys5pao8/7NDqjZw9oFxoH1PeW7hJcFvgbe9Ye81G/mUgu0Jo5LOGg2NxuVSPua4aFpt0fVuyzcvJrpHDBMx+PfPnTNPHIe9ZpEk0IBda86jD0ANm8IAG3OYchKMFClfbTLMXQnhl/NeP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370647; c=relaxed/simple;
	bh=z2ZuAl6m8mQF8bCGTrIOO7EDrjCj2YFxDmYFrGwTZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggnNqWMSHIwYgMkdg4HFmaHK/FKncjVmwm33nZ26hHzVXgvaOqPmZjDEmC74+9PZmHaIb1Vjno9jsFXseRuOhVHbmb8RdMA8uWdxjw7xUCbOsthLhsP/XhKw7YBPalPQpfaft5sbEdYlZvCNg4AmTsvjjeWHA13pR4xo9deyolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOvPxOeW; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786d1658793so1462327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370643; x=1762975443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=TOvPxOeWbNiSApawo+YHmwxouYBYo8ZqYZuOEzZ+ITc1CUWtCoRUQ/lr1DzgPoQiB7
         HxWmzzUT5AqskIjyw271EZGQLmVtgsXuWTg0I9KiP3ijIwHsEJH155nBvBla2uwVwtBi
         IDuzL2j0SQDNkDciFyUSF9kxqDKSwrBfo0+WWeMeFQsEW6cdDSdvjANMLQTdxi0xOjvh
         OP9P2RBiSf9tF7RiSP0/ddoMYB2jhxpBD+bcLvaSIKrLxlHFyqvvSfqlQOQtAuMbf67H
         GzSKHZuo1MKh/ZE0HCFFsTsnKb0t9uQsmfsuv8ABNSqMcDPoMjWopcuy1DOs6t9XbccG
         OuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370643; x=1762975443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=IKx5ky1WQbpu+D9f7gh6GNfT7JDJOHrDkyeWQAHK21qZh/4/HRGnxifOAN5FzK3b14
         Q3mKcCUgVB88wTS75EoK+3vlc7eD+ej1hVIkwAsO0pRnkSfKaS2YbuKQmO3ev9GLW0G8
         36mb0Kp6BwebBygMYkpKf4Vbf2YnXPWxAocPxJtDK5cVQcVyz2l6/s/g21UJrxC08uLr
         SBXJkGBtOijbVHUXDK7x+TXqRjpZAcOMebxfS0v0waVX/Y8e8Abo3aMbbk0yLc7xmNFr
         MoF9+Z7gtubqD9fi7Y5fjGPzIlKXkuNiNAS6Jj0L30mS1l3U9rSGQzjN3rrLCoioEOcq
         +IrA==
X-Forwarded-Encrypted: i=1; AJvYcCVjyiBd6hUOG2q1zUmrWcJSXjqhwDQkv2fwi6wAxtW5Q84WHWsL1kYTdfGHdb/inusnMVS9vJHBC1GuoRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRULzUdTmGT1nNk1vEZE/Sn3hknT2vMrCXhDUbkj9t9QXWE3/N
	Kf4iWBHblJYYNwgDo6V0qwSECcWT+TQpo/O8tTCFdPMjqvyKG/Tv48bg
X-Gm-Gg: ASbGnctUr/hlv56NkhP/9YWHFxtqf8muhrHP6+i77fGVGCgxTimYjN1v2nGcvCfVBIa
	5JqLtC35EFHdSQrkd/EaGcg/hNDNn1mZhFpoyhXAEkD6a1aio9d8i5mokeUN19GAZLT27+gd23/
	T1T3+c+0GXX4WX2xjHkgxUTx5sRjt1dPhy9fczCS/aKIUMjKFOY+IB/LAcsjVnV9MxwUnbdgW+z
	YtPlIWCp4yBTfOo1iZMSSXR5VzfHy+Wr+lBTUCXtECcmEBhTaKgMWv2rf7HCQufYz9puWLWu8lF
	nRx7y4N8NXasOGlMBNDLvDGEQTbmhYtr+41OdKhhQWapXER6gUZPXv3yQBKyIwzYjc3DunQ6N4h
	iG+OM+MOU0bDbwkMx6KmoRp0N2RRgExre+lkvoc0iGpTmoBar2fE4Am0GgHFdU7JWw1EfxvJ4Yx
	ZJcxcUQl/+5ip68O58LmpO+Fk3XcZh/Zpxs70/
X-Google-Smtp-Source: AGHT+IGzkMph0aR1AuSLsLz+NyiUmW9UyqgkXIKscDfhGHTikd7KQOHT6TykmLaTJLeIJUZrZX00oA==
X-Received: by 2002:a05:690c:61c5:b0:786:a774:e415 with SMTP id 00721157ae682-786a774e5d7mr54395367b3.56.1762370643208;
        Wed, 05 Nov 2025 11:24:03 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5ca403asm61413d50.8.2025.11.05.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:24:02 -0800 (PST)
Date: Wed, 5 Nov 2025 11:24:00 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <aQukUFyuN+iJ1zv9@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
 <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>

On Wed, Nov 05, 2025 at 03:48:09PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Testing with 1.37 shows all tests passing but emits the warning:
> > 
> > warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
> > 	The following versions have been tested: 1.33 1.36
> > 
> > This patch adds 1.37 to the virtme-ng versions to get rid of the above
> > warning.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I'm just worried that the list will explode. Perhaps in the future we should
> just define the minimum version that we are sure we can support and the
> maximum that we have tested.
> 
> Stefano
> 

Sounds like a good approach.

Best,
Bobby

