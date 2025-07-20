Return-Path: <linux-kernel+bounces-738319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41712B0B712
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9394189667E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B9218E9F;
	Sun, 20 Jul 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhNmHEKf"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD81C6FFD
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031037; cv=none; b=Gy7TR4hFJylOGdLjt8aBmn3yOVlGH86dielPdlkbl3pbrIBmRl5k9KwSMZctgvLl+xPwX3436mSq/VIDUfufT29WDWDFtqME0dATGzaDSKTTcbBrOoOCHsa4/uucMvWvPKDoU3IMuBqM7iM5U6dokm6emtDfVeMnfPcfGtoCiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031037; c=relaxed/simple;
	bh=wG8P7fa+CjCn2KzlSN7/2oDr+ctXpLRw5KYUlsGMbDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMsfF12LeenaGRgAT3PuXEeRoTynuuzPn/volEGiEbDqqPU6Q4S1mnSTd/rbgGP1sOtxwcmiI9g4I78m9pLfC7zL4DTFF3I1eivEIBTTeBoLZCTuiL2oOCW3bpDVJ9YH8wotjfm/8oDTvbXisnS80xyCLwa7pyebSvJIKYzOCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhNmHEKf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d95b08634fso215764685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753031034; x=1753635834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wG8P7fa+CjCn2KzlSN7/2oDr+ctXpLRw5KYUlsGMbDQ=;
        b=FhNmHEKfiMXOqdwPXDVwlayfeaGOau2Ezb/647xV5MgZnfot/PLPLmOYjMBG5mBc/1
         meCSvHQcvClaVKF3dJ7Q0CE9d5Fnhe7mET2hJ6ia6QtooMOzr8WWHCb3XYfqe1dqG2uC
         ooHZ42YsE0YjT1lPvJnarc1Wy5e4rG3GDxYDlE1u0CbKOgzxpDYmIye3Rfocny9Qo0k7
         sPIHjb1SZ+Zn/jUM53TBckFZFZ2v/iWKvFD6DWfiQZmrAlmgqsnbQg2a7ZxtWXsPJLK0
         eyyGw+wupE44lbilYwo//88FtO5o1ZlSDNOHhatOfHg6L3vxREB9sqjJzVU4S2oyvD2/
         8Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753031034; x=1753635834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG8P7fa+CjCn2KzlSN7/2oDr+ctXpLRw5KYUlsGMbDQ=;
        b=KFYEpdtYuCJfUvdAaFp0hv4F3sTdCQ8/sllYM6JJUcmS01t2AJXsLAF2VzpVot8Dg8
         UhVO2HTJTFtU5Q8Q0uEi9Ao/QWESDor0IrRW7pm7uZtMTy7bnWkRrbAOSPqmW4NYvONX
         f1RYijdiOZNjxQHeKsEeYBTxib9M6a5hrK0g1iexLodu1sBODR/p42J3u6qEnsPRSSI/
         ZWvo6TUnye2HhYhA6JLnc0tXQ2owHivKogdy1LUpjWdE9LKv4FgL2OIhkc+VfSw5Pket
         2ASypHsARTr9GLfeIvsLmzDRcbIZ0Bj38e616slDs6PvipZ6uz7MVkfuMuzEMeveiwmQ
         pjkA==
X-Forwarded-Encrypted: i=1; AJvYcCVbx1as1t8akuDPUDAdrRCC4W5gUZwzfLPCUpU1tNd8GMuXNRtPCNaxqvKvpKCZuvrgqrtBnUPzKgM4QcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/NS9n9NvmspbGb9vdtYzY23husqvLNAgv3u2yGYkUIFRzC1U
	wJPSxAoTnrjWXZ5q50etP+ZfhUIAepB53TxslUOcawl/2TEO4Ai1+554
X-Gm-Gg: ASbGncvIxJAQH9G10IYyaIFNRWVC82TZrCYyTmHnu7CNfxxpMnzS+FiSAi5Er4/eZMa
	Z6lynge4EIo7kZo0uzHdJah0L/jScO2oXZfPHU9YDE3URxxqe5/RZQUZP22ooOOCJgPp/v5QM+T
	ho4QxNoXANNVRn2jQkFLmfN4dqJhMABSCJcaIEdlr+mo59O04Ir2Bzmzms8wMFXIGrxM/TJGRIN
	tmyaOlITc4KeLveT5OO1lFT3YzcSTLWE+GDEMxCL5T6uIbdVBMh/98VJA8QiSclhhP4vIFWKIjF
	GgEpZVtXpCcgt8M/i469+hiqqf2MNb+GLOsWCjbaG+2+KSFpb0QPp1EVf2ahsJt6dP6fcIHamPW
	nyhkAw0yFq0Xi
X-Google-Smtp-Source: AGHT+IH5Rdm+vH4W5AhIXC+AGFNXo+m2BbELh2X/ZxfchxR9k0rV8YyYQ6BGXYo+A5ggZJvXu7gDxw==
X-Received: by 2002:a05:620a:7085:b0:7e3:39ad:4c60 with SMTP id af79cd13be357-7e343592d4emr2776466385a.25.1753031034389;
        Sun, 20 Jul 2025 10:03:54 -0700 (PDT)
Received: from pc ([165.51.115.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3e187sm316638285a.54.2025.07.20.10.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 10:03:53 -0700 (PDT)
Date: Sun, 20 Jul 2025 18:03:50 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <aH0hdrEOhzsqjqMc@pc>
References: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>
 <aHskWESzZdyBFj4x@pc>
 <2025072004-karaoke-stilt-ef20@gregkh>
 <aHyvPWeN_4JmPAzc@pc>
 <2025072038-improvise-polymer-a538@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072038-improvise-polymer-a538@gregkh>

Do you agree that for someone who wants to contribute to the kernel by doing
cleanups, it is better to do these cleanups on a part that is not directly
related to the drivers, because it is necessary to have hardware to test the
changes.

Best regards,
Salah Triki

