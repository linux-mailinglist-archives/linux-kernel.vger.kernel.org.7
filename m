Return-Path: <linux-kernel+bounces-730295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46180B04271
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9C188D3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F625B66A;
	Mon, 14 Jul 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A9yTNBtL"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042EE2594AA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505236; cv=none; b=sHzJlg4OLB19biosSVNrxn/BjGniVtBeh0nmySb9/igQe9suL6mZoHzjyvgitIqo695QqRNA6KCTVzLJ9ILsOj3WK3B/qVMb9VM+H6OpHeWcU2bUK2W3YrZj/KAQO1yiOa/65ZMCxSFkUk3NG7/RN3+Gm38Tn1mq0qOi/iXWyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505236; c=relaxed/simple;
	bh=BqSpm8PNCUKVTxH8J5CRGzEctolfXeFC2z0fNOKLLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+WTqUOYbNtHGISp1VLxlPePz5YGAPiiLmoxzL2zBTk7wzoDL6F8VpMHfLLrMKOeyrOgR1RDeTNTeFlsYwxMZidamZtVGeYroku0gUCZLu8qkYtG8V+dzygx6ZgDQjIay0dzkk2T89NnR4RJLgjnWm5hYnP/GeOV8dN4aFvAEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A9yTNBtL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab60e97cf8so17187161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752505234; x=1753110034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K43Yrdtzk3WuRcwS8KJIPgkGui9z8KNkHJx2gzTT56Y=;
        b=A9yTNBtLdJdZ5od+OzZQ26jSqj5K24y1ikc/UukoSiJx8q37vwHuSdf8T4BHKIX5RP
         g4WW1TbE7KUQOJbI5CLG0/Ixw5VYH3AjMBJGcVXrXZnL3JrMZx0Icq+P3C3so8rbdIgp
         ioSvUrIcWanLa+ZE7FBBnAu+t68d6/BPeTfPoXv8keGpKtNkTCSj3/KQE3c/ngTdzuBc
         eDM6EzEnMGwHhgMWJ7EfJtqDHK8tvqRuAR+2rM0vvK+eA98IdjEHX3USpur0xvT9cs5N
         5LWt2ICniSGVIIG1HbYsS4WkkGdLMlWC1YS6vqGrH380+gC1+kApdWeZvn0BOs2067By
         KyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505234; x=1753110034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K43Yrdtzk3WuRcwS8KJIPgkGui9z8KNkHJx2gzTT56Y=;
        b=pTKRv++2gl1nKUDgrsKncTyvZ1iE5jcc/MvcoONBEJaXbkdY9ExNFDovU/KaHgGbDs
         wr4bYZDW7jP2ZlEnQG3ufZtT0Z/eYEqYL7JuJMV0fFKXP+h4gv8+ofvdlWTLDX150sf+
         6Tqg8fw1E1uHhUJVl4+AzPW2M5gmg297uzHjSfB3hvI1n/BqMxy7bTFffoUBusp5FcC6
         ML4thNdHmpUtEPvQ7n99z+a6HvvuS1iRNz1KJbW+O9ghRUJczLbUTGO/u2PKGAFsBCDs
         mKwU5hf54vUpAnXkb7tpqrd+YY5OiWfnScZukaQEcDGFTI7PGhoseSqY+pZel+R9WCOC
         jXdw==
X-Forwarded-Encrypted: i=1; AJvYcCV1RMGkJaRyDKKWUtxFABtm2xiF2l1QWrd9uEjYuABdFT8VX5rlbwnSJBlimnXsGT25eOE9t1UeFtsrB+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YystaO5kKhak/CEPcrF8rnnSJuwFgub1Ui5ZR7XZBvK9kkZzAX7
	MzM05zYcPJPVea62yez1T4A4npdp2UplTF2FtqdNsTArSAXjfqdC3Yl8Mt7gYhbLU/vYVX+tCo4
	s3I1+
X-Gm-Gg: ASbGncuGVm7DuvdAothmL9vaEemaK6FuJ0vQDP1H1iC/b8tVPPuNuiUNRFOqIDZ+G/E
	wBShCaZWGa0XaWl9zLA+C+aWR7R3Mfvbqlmx6gHQyFBixGWmdrH8tpJkl6W/l33TPKg8r8NWk0a
	e/mq3sNY8BGQbNXP0d5+32CMjova+pwgBs5GAB4Zf7j3SJyuiyHUXJCKdVEcDToFXiy6BD89oD3
	WPD51LhQ2r9cPW2SAY5L60CE2beDmGgcxO5gn5SgO7GAxlBCwtRvjmhzDCENQQ3LJSzOMta17CY
	VoN/jVBb3Fm9abJDlSeyjXN3BqNhR7RO+uCdiQozij7KvmDs78jqAo7oMXlLqNSyJ7dQ0Uh0qqB
	NG4PZE2R3NMhjOZYF4G9PIHSLXtPxoy+YYT0dXmNKppv5EOd0Y6rZqFl7uWIfQtQkc/0080Rhbw
	==
X-Google-Smtp-Source: AGHT+IGa7iUOIBOxm6d7Y54+RFCrKYNbdExiSoR6+R1Zbrt/FhZARF3G8J48ACQJndBYr9rSmihssQ==
X-Received: by 2002:a05:622a:5a93:b0:4ab:6c5a:1fe7 with SMTP id d75a77b69052e-4ab6c5a24d4mr65558691cf.52.1752505233674;
        Mon, 14 Jul 2025 08:00:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab5823310dsm23562841cf.2.2025.07.14.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:00:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubKfP-00000008g49-39Yr;
	Mon, 14 Jul 2025 12:00:31 -0300
Date: Mon, 14 Jul 2025 12:00:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 4/4] iommu: Notify requesters of IOMMU fault failures
Message-ID: <20250714150031.GI1870174@ziepe.ca>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
 <20250710134215.97840-5-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710134215.97840-5-sergey.temerkhanov@intel.com>

On Thu, Jul 10, 2025 at 01:42:15PM +0000, Sergey Temerkhanov wrote:
> Call the notifier callbacks installed by the device drivers when
> failing IOMMU page faults occur during the SVA mode operation.
> 
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

It doesn't seem to me like any of this is really needed..

Look at how iommufd already associates faults back to its own struct
device structure side-structure.

I think all you want for this problem is a way to hook the fault
callback chain on a domain, and that should be local to the domain not
global to the device..

Jason

