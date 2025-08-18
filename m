Return-Path: <linux-kernel+bounces-774407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10CBB2B1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835D762063B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A67273809;
	Mon, 18 Aug 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a7qzF0mj"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1D3451A6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546109; cv=none; b=dIpDD6pgdQIKTqvxotEAZycp/MvKiQo3fhvVRLN2+0XGx1wNygsLeegUwzNhRyOW0rlFx/Rxrfo9hPVZLqMIAXvL4Zvo3xPVqXem2rQgZanKnlvArn1YFVFb8smtlhyhTKkLS6axWXhcSdcF0OnKTK2gOapnxVZUwRyjgZuleDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546109; c=relaxed/simple;
	bh=LjzRktvGHG7Cm7GEADais5G1kvlEza4Mc1EJ+4lQo7k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ha70NsxaGEJq6IdCb2vQqQNzMeQ72Ucko1a1gEh8JMFxqy3sFln/bWj1CTR1KAEl0bcnkcNPWCg1dode2ADKnmg8+dbbAlUh8YUnsJ6COAcrt3PkXMkVcuJ/R+Y+7KEFVZ4UDI+T8QEdxx0Ghy8QDfR3S72DBb8yL87cztxqjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a7qzF0mj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e87067b15aso556203785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755546107; x=1756150907; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0abzfqB4DaFxIDFYMlxU0oD0cFz5eYdyEriw8AoXas=;
        b=a7qzF0mj0/n1yiJUi8EDg0cEg6JAqBCd4q7FxxWJqTqBCzvTNSh6VcCuheD8ZrBrsy
         UcuRS7hRovdxTM8SQXrGvlVHPcaASOb5P6EW21dG3IJ1Emeln5Otb9GV/5tklmA6kqJ/
         XvJkjd4FVjljXDY0EYqyg5KYGTInTk5L/v+6zDIfnkdbiA3FYHseOskSQbnr5WdMQbGi
         BZ944b9Qsc5jSEdJKV+ehTdc70HAo4tShq/RsSoQbdNTK9oODlEQOmDzvHlhBGImWocy
         HVU9TvOkPMLs6rUkn7QtVDmzeIyp0Czw467R7F5iRViRMi7E0EpEsI9aHyOIgI0NLOXp
         1l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546107; x=1756150907;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0abzfqB4DaFxIDFYMlxU0oD0cFz5eYdyEriw8AoXas=;
        b=eYUM/6KQpntl+ClAWRuw+fTtdl21qSlT7EKWNnf/vpzbarVSuQn+wFKYUH4uZzmCZH
         Q3dRi1xqyG3LpI6DV2oCmP+zx0tl3h8oHzLBspfSp+FzbXw9WhIz1G/u3YgjScMRuHbb
         JqPvRUxsztyljTYubX8I+qR5bTXXyiCiUOiaiBWmnWocf/87AA1BSSBpDCVVw6xYtjd1
         G+l78oBe+XeduFVb40/Wt0ZeGc41V+Np9wDZtJJmLP7HlPZp6/J2VnHrLi0cdc0Sjrhk
         25TkMIhHRt9q2YQ+bPpik8JiTCCXg1uIWP8JPciT7eywLEiSLAany4sM8eoKQOGXGqWe
         MgDA==
X-Forwarded-Encrypted: i=1; AJvYcCUOmtsgSC21b5/jcQctByiDLzQzFi0ETpzbXBBYfezUh4rrTJm4FB4L3v2mKWKHWbppDN/4TxbC7mCjtvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIA9fE508PC/sQrpEI0lHy12nMppcjOmSUBI4ndPC89lcYRJQ2
	4L4QuNN6yODsanwD3r6MeTs6VVfysDFbvpaxBd973SR/WVdNWe6elM9g5XqT9Ixp3g==
X-Gm-Gg: ASbGncveZI/PP7LxS05jc1vmaxorxY64j8ZKj0flm3aVqGvTF5NgipbDDstsEMchqCs
	tsTO1kae/wG3D3Bg/cy+HZ7CQri12fWsej9J57ZleSTdNMi+D2UU+W+uA7V8mzDr6uQSxy09eC/
	tJ96IyOezRD5QN3XkOIHUhWkHV01FyRDqxWukh4iUyXZnqf3vEBrNeKknjFnpoJ+RC0XP4+sf6a
	CCSmezEg99xwz85uUWL2R76PGJImvwXR2RwAvbJiXDipywYWijflcw44RYWs+ml+Vn9bxrYWqwm
	8xlS/w0S2AxTYYs+zo+Q3k9RgN5c1rkAQxMD0/DfGHIRu7PKdF38Dgj6oXFSiMSGo1GaGXkECtA
	2btV9fYr2tWrI7yRr3LXFLOmNJMlW9mG3TrFxaQQd1ejNEQQmOA3IHa2XJu7fMTupeDCb
X-Google-Smtp-Source: AGHT+IERO82vyP3dtgCXTre/8LBPdqmJRpjLyPSaOmYAEAa6+wulpMpZnaDTrBO368CqbS87r5X4jA==
X-Received: by 2002:a05:620a:4686:b0:7e6:9644:c993 with SMTP id af79cd13be357-7e9f331f874mr16087085a.15.1755546107054;
        Mon, 18 Aug 2025 12:41:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70bb3ddaadasm37878106d6.70.2025.08.18.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:41:46 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:41:45 -0400
Message-ID: <3741abe96e56cef5bc0af788c1e48c04@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250818_1537/pstg-lib:20250818_1537/pstg-pwork:20250818_1537
From: Paul Moore <paul@paul-moore.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] security: min_addr: use umax() to improve code
References: <20250815035604.502874-1-rongqianfeng@vivo.com>
In-Reply-To: <20250815035604.502874-1-rongqianfeng@vivo.com>

On Aug 14, 2025 Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> 
> Use umax() to reduce the code in update_mmap_min_addr() and improve its
> readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: Change max() to umax() and include <linux/minmax.h> explicitly.
> ---
>  security/min_addr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com

