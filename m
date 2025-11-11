Return-Path: <linux-kernel+bounces-895272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290EC4D679
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260C23B54D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6953355051;
	Tue, 11 Nov 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="k0pL1e/T"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78634F491
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860219; cv=none; b=CvlCCmGya7bUlj9eemwWoZMjxg97S6A/A3nDfo4BYdDxXvwaWUs0v7jRqHqywoLDD6VE82PbXC8xTe4A38ZLKsoMxhVMNlLvV3/qd9HIJh7RqXxfQ42NcBpALB9olDDxm2XEVzPt5XX3ELz3OWGcaII4ykKePIB0k8XjcYhM530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860219; c=relaxed/simple;
	bh=H0LINo+13Z/hJytF0VdChjfeCAxAHISX2HNxfIyenMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6YgctzysfOewJj3NsAbS1DwnRhvK/erg2t5Tl2qrMhIuBbP2u7SyIXZMxPQbdW/wUh/5za12Y0W5iKccUu9O6CguC1G2Hx0hHrwxteZbuYCkyGLfosupzFZhB0r5YS+Al78vLZyhpxdAlt0nbkZM3FHKt+29Cc3vturTKIsHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=k0pL1e/T; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b98983bae80so2444132a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1762860216; x=1763465016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WD33dFwh8vT0qTWS1ypf3i1K/+5CU5E89Hi1vtjhv9s=;
        b=k0pL1e/TctlpQMM0EqQMKgj3Uq7XW6PD06Ts9TjxFLyBRnOkDliPKPHGHGKBFwiuvr
         aOP8vy4btcG2ih7q9fH2XReo03+Vwm1tD1h51QPmoAbMnGpBKMHQC+nfQy2SU/ZIGI2M
         BXl9QRTgMYEonJKSKbHwc5bMvImLNTNj4q/hd3oFhw3VntnQTGyQ2lAk0an8BM0Zvve7
         f5PQ5NcjWhCcrV8YsiLLYSGPa6laJ8cJnrnYrL6Eqyzn0nQ7K4Q6XZbSBNamCO4KadTk
         VjXNiOt9KZ3utaxpQMuf53+RMcKIAUXj9eBonzR3+E5sM+Gf7eowa2XT+I1l/IvpSktW
         3Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762860216; x=1763465016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD33dFwh8vT0qTWS1ypf3i1K/+5CU5E89Hi1vtjhv9s=;
        b=B2eoBx8rp+r25ZEsdUW/AYDg59KBzN7Llt673O1huMp5c1Nwjx0H+mCGr0mvJdx3ar
         tTBUAXQYm55WR8shyksO6anJ8OCz3Tm0mgW8VWUyJLlzBMkGk02R2M0dwpky6Zm58dd2
         TDz585AMGxhUtwq59MlCo72yk+IV7tjntyu+dZyE0RjuI1CSwZGBI3xsMyCytp2KgMtC
         o/bgEbbUJwIS+yyX8OhZtm3o4EUkd1qy8BwyRLjuYiLfxfgPQr2zENkLzyhB7VfbPMaR
         xeEA4KDG8ZJ9OWrtEAbKAqGdcKwzTUMtj5JIlpDY8QYNlMMjlwJvYBRG+Sl/crXIu7sf
         e7xg==
X-Forwarded-Encrypted: i=1; AJvYcCVKgxzxzOa40uhzeuszF1CdfXbWolumPPiqIJ8/DNalS2/aSxe1dV8lHJ75xqYOBUqu+UE9tnlnqbqY80w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsMq+xku0R0IxJNXgEeGv9U30h+5u3kyczHDFdWXXIVF3DUep
	UI7TxRfVQZfw9QnW7FBX//58oedrCE65MeW9pRfahPNDuUWq1j9zjvHJ/LL40WiGLkU=
X-Gm-Gg: ASbGnctqkGw3wSmzem/tLYWf+p2t6rq22O5L9wEvU78iPlplnzB3IvUdCjWzw4NyW+y
	NQugckHKiCiFOG4PdolK9bwCFcwig6Qph8KZ7tbjpndyQ9SrrE1Eqv3FhXF0snO/u3pMWBSlSDh
	ZOCf8WksCuCG7AY5uYp0a9hzzwrc5R/90Zv6mR/ny/Qd8LNvQqk+fPOfKwbJYId1THNqPtvLySM
	ohGYay+DRYQe4qVXPdtLjsaWEPrI5nVyAexcJ6B3yZ3CX/Uaa3eTNgv1s8IsZBser/I4GYHVfZ4
	jPcDlR1ZpfJGI3EQVjgSlu+2mg07pDMzQ8iseD3F0fDy3fZyJO1ASfudgt8mkdvJg+LDdIo2Bw7
	cjNVKcGofeFlZr1Xv0CKGk7tLgZqxYBO5eiDR9FTC/R4rXoSpwkXNCvEptlWibfHn+LD3wLeukD
	LWaQ==
X-Google-Smtp-Source: AGHT+IFboiQwYKl1ceB9F9QcGU+lPkaQ7+H951dK4YY2Nct4gKPSC1sT1xivKHdw2Ucy5iBM4bT6wQ==
X-Received: by 2002:a17:902:e888:b0:294:621c:a84b with SMTP id d9443c01a7336-297e570af71mr137445685ad.56.1762860215901;
        Tue, 11 Nov 2025 03:23:35 -0800 (PST)
Received: from essd ([103.158.43.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c4c0d69esm1183598a91.3.2025.11.11.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:23:35 -0800 (PST)
Date: Tue, 11 Nov 2025 16:53:28 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, 
	Roderick Colenbrander <roderick.colenbrander@sony.com>, LKML <linux-kernel@vger.kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: playstation: Fix memory leak in
 dualshock4_get_calibration_data()
Message-ID: <gwriiuvepzg6zdmrpzuswvpcplxtdobhagmgs67325ioesqm3p@5ivtfz7ob2mq>
References: <20251110171552.95466-1-nihaal@cse.iitm.ac.in>
 <cc4923d4-a24c-47ff-876d-0fddc0b8ad1e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4923d4-a24c-47ff-876d-0fddc0b8ad1e@web.de>

On Mon, Nov 10, 2025 at 06:49:01PM +0100, Markus Elfring wrote:
> > The memory allocated for buf is not freed in the error paths when
> > ps_get_report() fails. Free buf before jumping to transfer_failed label
> 
> Would an additional label become helpful for this function implementation?

In the function, the code present at the transfer_failed label is shared 
between normal and error paths, and is not the traditional error path label,
that's why I put the kfree for the two cases immediately before the goto.

Regards,
Nihaal

