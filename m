Return-Path: <linux-kernel+bounces-889714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B20C3E4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18062188B833
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B2227BB9;
	Fri,  7 Nov 2025 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="cn57xZ0o"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3E21767A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484777; cv=none; b=uHOe2NKJvIFl5mtO/26AQlTVY2ypzJIVNsoqh3oKmTXqzUvLFFVpSZBnwqloCYBUXYs+6meMtxLHS8spOF+PA/xhebKVCShoiy0TK50Okoo/vLO4s+bCN8QTNC/4TLWfqoQEkKerLnUS28J8+Deh3jBEvYKEnH+lKKsqeamd8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484777; c=relaxed/simple;
	bh=SqF6cjAe5fIGfKljFwR84iVXlUipV5ARm6YRakF57pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQSL5ImdhcjrT1inkJTDXukg55qxTh0xo6QeBhewbbhDLiNjVi1pk45U2QKuIChSQbqoT5TwF1kTxGgMeEkhDYfDdHXFIYpqmha5DivicCJ4xaBKUHM/5mcUglCxJTgyXPNyc43xiAkt1kWqflHhO4FfPxoalDB0LTKKSDB7GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=cn57xZ0o; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-879b99b7ca8so3407306d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762484775; x=1763089575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E56miCz2ucyW7p5RTNikjLhgl4gC4pK61qcfT2Qpt0U=;
        b=cn57xZ0oPlgAD+CBSKMswSkoX9xKQS1HixdXW5ECEdl1/YgEelftUJw1DUcEfh+duA
         CqyX7f9UdS2NaP2m4VEwp/qSKjRqSQDW17RbaRWRXGTqnivMrDDO91IRo5di4cHofFo4
         dDmQShLEs015pKEKpL5+2L1UsNOF0CCOCELwr7VtTZodwebonazUVnNh52D0rcis0esS
         z9KV+2j1vbSwr3RhKOGq0fn9HINj478kHnk0DOEWVuwsrTs0VH637mEM4F+1mdG3XZr6
         s+cYsLKU+BMUC+arbyjobnJQiPwtQZS8rT7DMBjEc8kNkXUA+YVqrxCLg6UDZ1dBhD6f
         oIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484775; x=1763089575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E56miCz2ucyW7p5RTNikjLhgl4gC4pK61qcfT2Qpt0U=;
        b=Ez48TzWESLQnUlfx4QfrFPqJD6T/GcEf2+FUY7YRj+rB644W5WyOHMdajzEaxsz73I
         tGhFFCCuc0v38h3cJg8zbgSmzNVwYXUeXwUmGN9iPflkJTR3X9ygk2s/5R+BLpgeIfg2
         c++MSI6q6t8vqOCXfNTRuDaYaqKRNuPegbZr2nJbBbhUiwXD7g57mwG6nkv783fh/AFL
         owyz5NrJq/aqJ9MVUSZAw5WgMaj5VUnDMCrt2unLW4ckDKtfALfIpx4cvUm//PnLQVEa
         Y9HdeLyY8U1mB2lF+VvuZCJ1DGRxJ1iMvISXajnWnv276q7uEB6Ur6P5Do1v8vHscIxC
         uARw==
X-Forwarded-Encrypted: i=1; AJvYcCW44wxH01cczB3OOFbWAJM71zwdCeqIyidikEusKZKcjPOcZ3dRvf2zVCa+1g1FaLXahyAVXQvn4+x7TKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwP7WP1mNqGGt4rk0xps8YDj6Z1akr5awujWvPrBCk4i3i4nk
	OoP0WJOmlZxlzK4b357wcHO/asG/vjT0fI5SIgixZNmensghQkcHKrFKRO4nE4a9Ht4=
X-Gm-Gg: ASbGncvA5SVQF5LhJlz7ApQGDpvWxiNGrfpuBWC+LpUlzmWpPAwUDUIvlo1HcCmfeRO
	ihHGFCLi/DHoJAbjKQR0brWsoIoI+FsD6FN7qFocWnAhWDLrFz41Xan93kn20BadSOXilMqEcPV
	irN0Ohy6xj2ue5Mc5EyqYx7yuuHHy1LNnVj/nFSdFHMJdPW5sTX9YdjbGW13QmQ4yeKRM3YUeP6
	TETF8xAGRgElzdrbfv89FQ+ORxFSGfusRzuokQnib7mnN9RNuO5/TXVdh7+EKt0plAFR3wu88cB
	89HCvNSI5Jxa4scpruBqXrvKnbkj+/CcDvG/cVSD0zymHQURlmWkQlR7CS6gkThJ/Y04H2/BJyF
	njaq9JDS2SnAYT+uahtO4iojizEG0g1zuszDt0gSTL6zYHbdeXlH7o01yiJMyn5qiC0GPSx8I7J
	dzbpnoYerxnixGqyeVmZA+6Pzy4pOosDYRdPJwvaYO
X-Google-Smtp-Source: AGHT+IEwrtDh+N2RU8TdlIkL8MsNx2X7a1H9tD28kPSplx5JFVcsb0223J9Fj+vOzbjZ1jDImx6R0g==
X-Received: by 2002:a05:6214:4004:b0:87c:108f:676c with SMTP id 6a1803df08f44-88167b17ed2mr26261796d6.25.1762484774711;
        Thu, 06 Nov 2025 19:06:14 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88082a38210sm30548476d6.55.2025.11.06.19.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:06:14 -0800 (PST)
Date: Thu, 6 Nov 2025 22:06:12 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Esben Haabendal <esben@geanix.com>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, linux-rtc@vger.kernel.org, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <e7ezfmqnbduq7jdc7osicqp4rnztu466gpbcxaoj54jfigsvvp@iroscsnamy3c>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
 <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>
 <ni6gdeax2itvzagwbqkw6oj5xsbx6vqsidop6cbj2oqneovjib@mrwzqakbla35>
 <35bd11bf-23fa-4ce9-96fb-d10ad6cd546e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bd11bf-23fa-4ce9-96fb-d10ad6cd546e@leemhuis.info>

On Thu, Nov 06, 2025 at 11:25:55AM +0100, Thorsten Leemhuis wrote:
> Just wondering: was this fixed in between? Just asking, as I noticed the
> culprit was backported to various stable/longterm series recently

I am not aware of any fix.  I just retested both 6.18-rc4 and 6.17.7 and
there is no change in behaviour.

Thanks,
  Nick

