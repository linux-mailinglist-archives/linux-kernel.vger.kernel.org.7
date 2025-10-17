Return-Path: <linux-kernel+bounces-858144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA745BE91EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B691AA30BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941A32C958;
	Fri, 17 Oct 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BTpqMGqw"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9C32C940
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710396; cv=none; b=VKg10vkGVaEq3O/0W5iTRXd8B/OqvJZTrKCu//yXwN4loaZcKFKz4L7T/HPW5Vvh226GWDZMl/oPObjlpsb7w7pXGjAZOcaqwwYcsrBr1lxpBxpPp3uTa3WfzmhQKvgwV8pDhW5l5igtjziBzqXwvc2D/ws05d2sNwNB6AUMzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710396; c=relaxed/simple;
	bh=gwvpwm1LLRYUen6mXbmoaSqbBuwMxLRMvKkgD974mLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLOfxyqphVTyxV+uuYOHzamMEkOLJoiDvHEPViCz9hjGgH6irAMAuMTR/B9gjzGL6WjYpS6yv+FfyVpAvmgwQcMLcWnawD4m5Kv6GWfepPdky5X7qlD6IpWvbV2CDFZvFPtuhepZWx8P/iAMlsmr8C48n8dWNyQ6892ZqX/FzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BTpqMGqw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c2816c0495so444059a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760710394; x=1761315194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCa1krvPa6thrRIUKnGByTp8gWYsBMbtC33XqRP3axo=;
        b=BTpqMGqwxaZ6CDDNfBuKcbk+uRF49QVIjV97gQfT2fmPpf0/l5CwtOkfTEbllOz+cB
         2Gl7waz6z+QszVqJcVt2PyWTQCzLeVklgf18bfsWeDrsluREtEDgk1/Mk//IcOrjVWVz
         TJlAV8mViakZlv4u50SAK0UjJ89HQFwFW01Kugn3w+AYSp+CulJgvDYnICMor+EwZ3te
         DxR1uBfDMckXKcRhet6NWTMcWztztcLW+WTdAr+dfxt0f3BeL7l405pGNm7PV97ATEZz
         +jslxSlqz9gAzPjiu0yLRmy19Ca1ucsFvCE+QuEpKVRQ0HPiY78lRGVTTxry1+kmz/sT
         xhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710394; x=1761315194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCa1krvPa6thrRIUKnGByTp8gWYsBMbtC33XqRP3axo=;
        b=kiAqgz7N4IZH1ZmUXly1d0WeUE1NtFUxqGoNbRYEJsFaDWA8x8+E33g4nstdrxG4yk
         SaueBbhb7j91QpvSqEMIWXbnZ9r/GS8CynZfi8XAroyZB5O5qoKtYndaFwP8dmiDylLe
         j7EcA7yw7JOf+Njcbul2Hyutxk6s4sn0mUd+qVI9hv7MJi4zlhywHAEsTn3e34dcL3FL
         jT29TETxeuoEAPm1W97Br/TRHRN7wMUoMUw6uSl8j31Im+fPdtTrJdaO+gN5CId4IPkF
         iftkBsEcg5or6OOCEpoDygo4fkSQNModtKt1sjLmQtAThK2MnkXcEFhGs2GjBTosPMY4
         uTAA==
X-Forwarded-Encrypted: i=1; AJvYcCU8XUc1Y0qwnLAUMoEtY5ggxLYVZyOxbpBnkxx6RCL7NlFrSNbDRqmxLenMS18Fg7MR/PlzLkIvDyJ6DKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0lh54hPmMAMFZbkNK8zsUC3qWOKShmYJGwGyMhpsApTnYHh0
	Dinhlc4l1BQhO0VEUQuBO3mmV68mCOnCUrZ764IulH5rnGwGry0RyL44SIv/37IMiuw=
X-Gm-Gg: ASbGnct3LzmTCBjPj1ashhUThRH2U9pGLpCRlIQsSFJ8O5lSfxU6brCns9G21jAZlBH
	sBnYwbyKv979zW2NrlCsgov/ANJDS2JjDLKkDxaPQSBAqoAOvUj2TiWl9L6Vj/+szui3tN0E3zB
	DdcHekd5T/HiYRDgyUVZzh0Ek7vhXOHnJq10LrAFNKnWdHN/qC964owa3pJmue/2e6tDvjM5tIR
	XvgNbGUPuINvgdRbN4udD2LwcN+Ry2VRhMaeQl5FF/SuOKQ87vGOUphyElgDpVzc7ydubc7+mmg
	O2v24N8OIU0/hhi7FFJcuYuXklfWwkbg1wiuFgNQJ6PsoZXmiNBpI8YIqfXJaZt2Xw9N3RvIttT
	a01DFToQegLTnGKoFfYZQEaR6Q6SEAuR3iF4YgQ2gDhDnAZJXPk0w7VohPww9
X-Google-Smtp-Source: AGHT+IFpxOdk6Ni6feiUl7Z+NLPVA5NFJEIRLr3ye6HX+wgeHy3UR1Agbev9kB5TSYS6S/8PSXPR5Q==
X-Received: by 2002:a05:6830:610b:b0:79e:5341:392c with SMTP id 46e09a7af769-7c27ca2832amr1811887a34.7.1760710393815;
        Fri, 17 Oct 2025 07:13:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f90687e8sm7323680a34.15.2025.10.17.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:13:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9lCi-00000001JNh-0d7r;
	Fri, 17 Oct 2025 11:13:12 -0300
Date: Fri, 17 Oct 2025 11:13:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20251017141312.GP3938986@ziepe.ca>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
 <20251016172524.GN3938986@ziepe.ca>
 <aPI-8YfqC83QlltH@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPI-8YfqC83QlltH@google.com>

On Fri, Oct 17, 2025 at 01:04:49PM +0000, Mostafa Saleh wrote:

> Is simple enough and verbose and can distinguished from test failures,
> it will look like:
> [    2.095812]     ok 1 arm_lpae_do_selftests # SKIP Failed to allocated device!
                   ^^^^^

The test "passed" though, and since we never expect this failure it
seems wrong to make it pass.

I think there is no point in distinguishing "infrastructure" from
anything else. Either the test runs to completion and does everything,
or it fails.

The use of skip is for things where we probe something and detect we
can't run the test. Like maybe you have a test that relies on
PAGE_SIZE=4096, or CONFIG_XX so skip other systems.

While, "I hit an OOM so I skip the test" seems wrong to me. Maybe the
OOM was caused by the "unit under test" leaking memory??

Jason

