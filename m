Return-Path: <linux-kernel+bounces-738641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E514B0BB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90271897B50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A281FDE33;
	Mon, 21 Jul 2025 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9k4ZDt8"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE691EB5F8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068201; cv=none; b=mhNBn/AZazr2HJ7azLADOROF7v7I0FY4Ee7Ax1sNPbrcaJ7oMghsRtPw6T/4MWmv/xAXMGbYz8iwDhF74x2jKIB6vYV0eBfxgec/mzrAjGEVSRwZuF+Qjvl2GlzzxIUeN3B/8qvaB9t73n28D6XdNbKSPrCS5uepOeluY5Omxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068201; c=relaxed/simple;
	bh=ccqhZ6D/BBFVT/2vphyPtM9hsxZ3BdFQnc0Ne90kRXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=les1EGkk93huQuONwS1WzNLPco5CbMX5KNd0mUSN5cRv3BgQkIJITH+i69WNegQQ6WvsVqQ+Sb9/ygoFTqAQE+MXWLeQtS7ACnT/HufcQ1KfDqvJnKmXOCcB9JxWcIhbVZYP2Ju7LnHaLG0Ah/2oGJ5qlFXzXmw807sSIK58jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V9k4ZDt8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2828859a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 20:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753068199; x=1753672999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQYfFfM/mtR1CICbJUBbGQ90ReaVEsvi5HRRAnkzelk=;
        b=V9k4ZDt8uy4e321aKMRrX2kTOqpGhUnbCINVuehoqB3B+QcudnSgdJZRnbd1r4cEiw
         V9f6mRphNV1M7927W8ojbuKPQGUgha51cMS4NqJaJ31idC10waaRP/SDUS/oaG1478fe
         +qNRVYURsql0MWgCgStpj5/kDKJiTOIQvJo4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068199; x=1753672999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQYfFfM/mtR1CICbJUBbGQ90ReaVEsvi5HRRAnkzelk=;
        b=qa+m5hL7v64tGr4nVWQdm/jQSn6gVkiz3pretsr9D/splax7raDgvHTiPwBkImGyOY
         DYlmIWcPoWlP0bTiwbR040lRZ2Z6fVRCbq7ffc0sDBsn0WpObvIlRUGOZrlD93XEsZei
         2zYxhzmybJKEXPTpbNPMdot44vunjUVrGsxd1u6cW5C+6cneondD/ZLq1ew00+uYI39K
         4ZcHaJflJ/I1kI8CIxUNb8X95dySCeyNKRznh6+aIbCKGE7RKkZm7afKduUmXjrGB2O6
         Wjq8GSFJIyq0xJIMYIR6WPHfhYi9m5YhJl7/wLAVXNs3Tv7vgr5uaO98S1dbCujMy9Fj
         Hovw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ59Gp6vGkoaEfpKmL8cQeLq+Wtnb50uCbrG++zypR/qoJRGMfQnTf4EpxFb3BbiXe37YM6vAEtJWA1S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6M+TpO6GXOkVlC624n48528gugBShEIdIGWYRedAwXNbtBXAw
	PeAWG2Qoz0K8H3i9kaVgua65d+F7h8HJQpiPF7qgfomSFv31FdmoXQ+RcXeOmpfmoYA+0xenrcb
	6jZU=
X-Gm-Gg: ASbGncuIkd5QeDwCM3kk0ec3Q3alyKrQi5PXqj2xmlKFSJhI1He2pDQgvGtDNCeCLPT
	cZAAkAkAnDh7AmU/IneiMsfgPbLM3ztTLvY4GgXc50MF68oQY3M26MeY4OygJN8ZXF6YIXT+P8Q
	qpUQga61QRUh5pfT+XK87qdmHAhFMVWCghyJ6kQNv7iyxzabCMDRGhwfDDxcPCokSV4hy07znZH
	MegYaH7za4518EWf1+GVA010DTpnAir3N8U606E35Xfv5ax9JecUt/+s4ENQEhg5eODlqE1+f4N
	Vlvce5ag5sdaY5csLd2HH+POkyNE6s2uCpdqF6K02tuIqP3Tkojl5tG4uHVF1aHRyVl6ch7EeU3
	oaVZ5jUSYyiy+A635yBpvUDvXNLArhWtyCt8D
X-Google-Smtp-Source: AGHT+IGMOr/h4t/0+dcYhb0THiLSuS0RfTOtcYQsA0CBLh3fChq1lYhkQ68N31p/ZeB4Swgqevsz+w==
X-Received: by 2002:a17:90b:2d4d:b0:311:c1ec:7cfd with SMTP id 98e67ed59e1d1-31cc25e7a85mr16061926a91.26.1753068199361;
        Sun, 20 Jul 2025 20:23:19 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ca29:2ade:bb46:a1fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e4571asm5092945a91.6.2025.07.20.20.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 20:23:18 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:23:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <r7mtqczhwcyt7xwpmvn5k7iwevta46z7xsu7t2y2xxnwlv7byc@ksiuu4zlllod>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
 <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>
 <aHzZSKqAJR9Wk7SX@equinox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHzZSKqAJR9Wk7SX@equinox>

On (25/07/20 12:55), Phillip Potter wrote:
> > I don't have a CD/DVD drive to test this, but from what I can tell
> > the patch looks good to me.  Thanks for taking a look!
> 
> Hi Sergey,
> 
> Just to say, I haven't forgotten this :-) Have run a few tests with the
> patch and so far looks all good.

Hi Phillip,
Thanks for the update!

> Still been unable to replicate the specific issue though.

Hmm that's interesting.  I thought that unplugging a USB cdrom
drive would hit the issue relatively reliably.

> Assuming my testing uncovers nothing else, I will
> revert to Jens with fully crafted patch submission in next day or two.

Sounds like a plan.  Once we have an upstream patch we can cherry-pick
it and roll it out to our LTS kernels (and eventually to our users.)

