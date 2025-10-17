Return-Path: <linux-kernel+bounces-858556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7ABEB227
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6B64ECE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D132C948;
	Fri, 17 Oct 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb/LqG49"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA12C21D4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723994; cv=none; b=ZjpkfILxW88RRGOYvhtydI00he156bkqFqKqTAtpZu9DuGpfCKdld4whwjL3qASMwo7JMFUz1hoRZE5iGl0fcgoMkqxOIign6G0UbBsiwahexTtaSF63Iff3sZE/711WZwHatynWvIPhABYd+195ejUUGqtQO0+HuLr4HFxSZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723994; c=relaxed/simple;
	bh=ZzH+32i9zF1DJuIb4vfgQHzdhY7TJS9MME3F6gVefh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgrZMMmam8wbV0oMlEFzG995YngP1am/uGXuz+Bsz+FDLf9FIR8TfXeyqTtrSH5YrY50u0jj3Yi45jeNAB604Iq0Ki2th6JfFGpb2Ao4KBRRkGDcNZes9Rnx5c3+YHg9sytMGfH1i91jt5w2bpWLrHC9cb4ANYXDBPX3B0zl/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bb/LqG49; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471005e2ba9so5225e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760723991; x=1761328791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cm/Xe7cjynibkOQ6Px4QnhuGS+eC9ZhGU5GEHOrppAM=;
        b=bb/LqG49/a3gOCRXMNQTPRI75zkhcmF5MKzUpsZpEBsas7CPLblgZn1h9cuwej7wUH
         hzJh8VmGMphiOVXyAxVmTHirlbISz/HooRetwBvYxo9vqDP+RfnNJiEFE6h1buN7Zy+F
         EyVRbLsRGMwigCHXP3DKjrShThuM4xz9dmef4yH17IWf1H3Ez9Yp/T8S7n1NW4aYHzjS
         SwJ34N4GcVUxZp8fZ1ZKF4G/QHO8e1xxwouIb3BvtOwjMl7wlmOK3u2zrasqYpmpGJkR
         UafrX24dhtRbRi595TokFrb305ir0SHmOXhJcj7VICk4icy/41eom5GBrJZphNRQ0pVe
         WvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723991; x=1761328791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm/Xe7cjynibkOQ6Px4QnhuGS+eC9ZhGU5GEHOrppAM=;
        b=GjS7DdbI8tA5du/O+LL8bJtrtMYeKaK/8eTD/sIra1tYe4a8lIjvZdMCyTxVZD0Swu
         ll2fjLGmA+L6vTrRyF/nogepkCD5y11uC5Icsq/Y0CwcvYaehDfe+oCPt4zAsJllcoRl
         2CDYP8dACTep86Dn1xAilTMHVmB2Q7iZnBXBiqljFyzWnAYUAcgGgTJXpiiTct0MqzVW
         7o5KfMTG5btd+rMd4xvdNdKh6U1XlX9Wd0SryHWiS10mz1SItCkt3KgVIkYtRuNSxPQ7
         uBbRdlsAlHFpU0JMoqzga6DwWq8WDzHq77PcHbLCYBA0zfJUhbesYPhBz4n77Ki/7n/Y
         gs7A==
X-Forwarded-Encrypted: i=1; AJvYcCVMDk25JXUJTwMgUbSf1jlxKC/7V1rvJZv1l8DH8g/kjCv01qawtMj4PQwQ8/JgFGP7HiQRDBApD9n6H+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XyBnzKL3VAiqYd1wk1nhL1B1MU+886hkfEVAKDSh501s6QZw
	ot0cyOhO7tlMc/C2eEMiYczUJuoYS1O0Yk33F9F21gReG4ijUx93kGM55PR2pbl7WA==
X-Gm-Gg: ASbGncuQeKcovUaXdV0+cAg6nvLVzZXzugqZUmk/E5lOiDhPISK8k4VbUyM1IMl1zI0
	3/So1Gx+v+EjYWFdG2JfqXRH5J4n7PoGiGjtzIU2eWzFBdHdG4/wRZ/ugZyPsm68T0DAtODZy/F
	C+mFVlHyGHuMQbzFF9JR5kNavEnHFT7fLuyuB3etegN5q2qv5hYfVaLseK++psWPHcaR6vy+CbM
	AJX1L0WbKpsvvTUSe189Mkk/sg9p1zMyQT1s/U+X/0fEc2vFFqJZFc4vzieOSTprCvzpgx5LSTl
	mb9tTp7Mk/JjTodH8ILxNbevzvjeZkl8eUEf6Qe6zmbUkRrQQHEY7P/OHvVIAytaa4rrJb0SXHG
	nLULFGn9W0nu3zKmoAiFvUcyRF5CJ4qQUeZHai1rMthPg/nb7yHjLSQM/driaTARK4ThFyX4RZ/
	xzr2p1N+VzJ8SeLzPkFW/0I+ZRbLsM5ks/cHRAgA==
X-Google-Smtp-Source: AGHT+IE8/FXhVVJrozgI0Wh8A6TqTcaQumti7JajkJKRLGU4JC0DDWkhAHhYmkS9bQHIRIjtvr95Fw==
X-Received: by 2002:a05:600c:4797:b0:46e:1b09:1cda with SMTP id 5b1f17b1804b1-470ff2e9434mr4517485e9.5.1760723990610;
        Fri, 17 Oct 2025 10:59:50 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm420433f8f.35.2025.10.17.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:59:49 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:59:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aPKEEuCYbbJbN9Cr@google.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
 <20251016172524.GN3938986@ziepe.ca>
 <aPI-8YfqC83QlltH@google.com>
 <20251017141312.GP3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141312.GP3938986@ziepe.ca>

On Fri, Oct 17, 2025 at 11:13:12AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 01:04:49PM +0000, Mostafa Saleh wrote:
> 
> > Is simple enough and verbose and can distinguished from test failures,
> > it will look like:
> > [    2.095812]     ok 1 arm_lpae_do_selftests # SKIP Failed to allocated device!
>                    ^^^^^
> 
> The test "passed" though, and since we never expect this failure it
> seems wrong to make it pass.
> 
> I think there is no point in distinguishing "infrastructure" from
> anything else. Either the test runs to completion and does everything,
> or it fails.
> 
> The use of skip is for things where we probe something and detect we
> can't run the test. Like maybe you have a test that relies on
> PAGE_SIZE=4096, or CONFIG_XX so skip other systems.
> 
> While, "I hit an OOM so I skip the test" seems wrong to me. Maybe the
> OOM was caused by the "unit under test" leaking memory??

I see, both are fine with me, it seems the kunit maintainer is more
inclined twords the failure approach [1].

So, I can keep the test failing, is it OK Robin?

[1] https://lore.kernel.org/all/CABVgOS=NfRcXYzJVMMKqeXP8SyTewffwb7vdGN1D8esO2f0KOA@mail.gmail.com/

Thanks,
Mostafa

> 
> Jason

