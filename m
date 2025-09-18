Return-Path: <linux-kernel+bounces-822904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D0B84F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD53517CC91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372227F011;
	Thu, 18 Sep 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aA8FTHCb"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19094234966
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203983; cv=none; b=e1q+H3vvZZpK5+9vh1oD17y76Kv1Gdy6rh7qQ3Lss891+4G8wxCKuqgJcYF6SgdRCU7Seg22HD50FM48CoQ+zbY+bGLQst08bYnpF8cNhIpGsv8orJRh2uW3LJaE14xFq9zbqXDHkbsZF+VFUlkupzCROIezeaJTPptbScDSiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203983; c=relaxed/simple;
	bh=N7r1cHBrTftOK36ML9zP4d5ZUGLyxB2f5d/SCmZw5mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYaHDPzQr8S6MwKmF+aVGd3He36V+Mm1Pe4h6sds9ACbmIX0De9bHgIrykOgBQmZvFJXViyPwF35Wym3/ImT/sicmehBXl8g6m0i4QnEE1EnVdo58xxmyi6fhx6I4gCDkNzLw1Diiww9v40JTy6+IL9rEUQm++Xd5GM+Mn5IMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aA8FTHCb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-827906ef3aeso92475685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758203981; x=1758808781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW5naJpelAa/fHCeFC/F6GWx7z3AKGF3THG0OvJ/RBQ=;
        b=aA8FTHCbDle2tc97WncHKeSCwpOCL05hcwK/qSyovwPliWJCj61Zgp2YtUKC0Dd6wg
         vum+/jkZ0Jqz1lYIaqk5s9otCt5dEJtJVuBb1HSNS9YCLd4hgUkqowcdNjwUjrbuDPYA
         e3OldE1cGkMovkBXwhEgn+NCIF6yI6/BXNNXc4p2kkCggUQz4LbrAlv1UXbnl2T1Cg7u
         QCm8Ec49IZj6NvSKTtzyDj7KpeQmcy+6E2tXWHzVDZnUKhIqqszQds7bNKP8aWlZ6dMV
         3arhfFCKiHxdVO4fXcSffdvSv3pbKFZHePRRPV82WP8k7ZEgqmqyIRl0tc8vCU0P13C7
         SN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203981; x=1758808781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW5naJpelAa/fHCeFC/F6GWx7z3AKGF3THG0OvJ/RBQ=;
        b=ImY8USzpQ5BLKkE4grGKHKFGN7rEkLIYrIm/fej9zlqapbtLrmvIOvFM4hAhxknWTd
         6KkoXURwAOlbJRyFDuM8ZC9Z967e8/nLJBnjh7BNv1PAsrj63dSOQnCV6eIwch86V5hK
         +8cbTUPjKEf0ofnU+jP2zqdmK+IUn2+8z5YsvwEKb1JZ7CszJ2jTkv5YgAG9EmbzBeNW
         zLUBQast/AJ4v/Z2+UN95GvPSCjAFPUcQEaVFSRNaJVIQfPEh7aO/82deqo4CkqXKRG1
         XoJMZEfz/TpQLuA2itMhZR9ORf/pF4r+26K26HxaEsHPQ5JMf3dkq1kZqJevVymhypAw
         dA8g==
X-Forwarded-Encrypted: i=1; AJvYcCXV6ECpTzTWuPgVbMy9p5B+8dDHTTNXyp4lCyfoOtT87aST/ZXYztAjGdXK9j6OGmNVBWVrRQYZNDN8AJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJZHsx71LRngDRoND0N5N5Twp9R5vbAYHDmtFIWE2DwAViBWT
	QpiRYyjwUBtG/ZjVNfibhqKsrGKunIm/nPmeZTVW6LfRY44V79fuMxUApEgyNx1N4fg=
X-Gm-Gg: ASbGncswST/jy2JnNDlH+pbfauxHqfrnTaoUMpYgvOJRRHvWh6e/fM+WDiAQHwvPihA
	25zRfHPKXasDTkEdmjHzZWTAvA4j0RTMn94WsYQng9SK2L3XzGzMe2lxO4g0JD8TW91VxIOAPgT
	EzKvote4OtirrXlaNH/chIoHhSF1d9cgVYlodaJrtYbPksuir08DAQZdTipQN0u+o8dulKXsmnz
	B7a1eassujn+C27pJEbmgHOSmRnqZjutV2Lbdu+BI6LH2uO7zYV1NbqkmXEvYA2RYIVsfWm6fvY
	ZleZhPT4orauhTvSFx3ep10AjWo+KpXnd4SKJg0IzlspVoSm94OEvXm2OC/FdHBDyYGs6/Ox2FU
	BfEt4K+7KiqZe0vQwTg5dxuQmqu8MYSpjORpjBkB9uredE6IkWioc3FU6
X-Google-Smtp-Source: AGHT+IEwqImpRBrim40+l6qWMgI9cnm3yGnyzb/zaQbv9aJ8e0v5cQdRF87vMbOiP7dnVMILNYmQwg==
X-Received: by 2002:a05:620a:471f:b0:7e8:2322:24b5 with SMTP id af79cd13be357-8310765993emr614510785a.3.1758203980771;
        Thu, 18 Sep 2025 06:59:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb91:141a:4eff:d16b:dca7:ed2c:70ff])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363203a51bsm166257385a.48.2025.09.18.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:59:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:59:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
Message-ID: <aMwQSYUXHtZidrpY@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
 <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>

On Wed, Sep 17, 2025 at 04:51:37PM -0400, Gregory Price wrote:
> You have to do the alignment because the translation function (may)
> only work on granularity alignment.
> 
> Example:
> endpoint1->to_hpa(0)         => 0x0
> endpoint1->to_hpa(0xfffffff) => 0xffffe00
                                  0x3ffffe00
> endpoint2->to_hpa(0)         => 0x100
> endpoint2->to_hpa(0xfffffff) => 0xfffff00
                                  0x3fffff00

minor corrections above if intending to use for documentation

