Return-Path: <linux-kernel+bounces-862344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FDBBF50DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 760344FEA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE628000F;
	Tue, 21 Oct 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XxyjuCio"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765F27B4F7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032788; cv=none; b=iFAVFrYSrAOGJIeT1BdFWMe9o+gx8jAerE3hJR5AV6HkJU/ezg+mCjRR29rlxkWPwCBxQaDpMKaE+4Yez1ZBM2R9VpB12zIJT63BI11gimaIovBcX+cW27463bTKG0Q9+tBRg8CcSY8lDytDXgywmNTvcs9tH8FhdjKREfOEFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032788; c=relaxed/simple;
	bh=LVH6YFEYhmhEPWh0df7RK4ekzNwAtISSU0LB8tDTTss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ERt0jakFScaXHLUrRpKZAK5gxHFPqK4GB95W3yDUtlTnKaVjMAqx/E4RN7gqMJQ41TsZbJdPGHTy8LLwFNG/rktrmTkuS3Gx/zQjkeH/Q7/oQNmpRcnJ8KohpY8VpxxpgU7d/5HJNHoLj8EMe/8DDWeQOY1+yS1ccRL1RQC9ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XxyjuCio; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3208959b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761032786; x=1761637586; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBpqb2+7U3Q77M+8OyMtM0kBeb1iAjGz8t1p4/VxoQI=;
        b=XxyjuCioULcSPz20Zlki0mzx5/zRssV86Dh5RXr1fxf4lQ2u1MPYSve2GDbRFW5Tvm
         SlkFUAEc8t9Zh35n3DjhuVYIzr29QFoTAQEIohtzjeu6+21rVRqk/5GBnWLQOZnsgCMN
         9Ls+Em9doxxUblunLlOXYoyigAr0OBaKJf1awEYzPIpMLrJNAZjqVtSVq/FxQ64Ibkyy
         +9ftd3zmsblGFI8hmTW2RLWS/cGONcYNlvzmaAvKt6ZXvnhRTORTyeMPB1ybNk8IL13d
         UjiYXhRSLajhozMZUD1lYbas3BdJH+qcflnWZi3QJQL3P1R0oQkdHw2h5Vm1HUPl+zOe
         3BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032786; x=1761637586;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBpqb2+7U3Q77M+8OyMtM0kBeb1iAjGz8t1p4/VxoQI=;
        b=Hh24e/ZleoqFhjXwCnFqvJ2XT5pNkd0juVGsK8QZfbH8lzTE9TNPNm+LNZqFAlw8qH
         ocuIbkTAAwRRH4uC6g84M+w4GXHLXD2rU7082tf5WN9LEmTN17ym98cgtvhJrr8TNErL
         HSds/THIXu45O2TWkLYRdxbkWqA9r2zeSqcLy4CO5qR4i75hSLledXcRRQsNufGBTxHS
         P72Ctr4gDiMkFLlz0sKLpuIrUqXgfAzhqO0PA/QJLCWPhj6ghbxX5UM/eSziLx91asnX
         ptlAuXD+qGxCkJk6XK0oSr9Ha1Fb5cIBSvZM4V6EdzhW5WJ+3+NBx68AKhEmawxAHqO7
         SJDA==
X-Forwarded-Encrypted: i=1; AJvYcCWMwwFCVWAEYzJbTn/XrkvmsgWQQ/yqoOqzLqUKkcLxwpmdTd/ID2lnajulEvVcUBbOcq5xrt5t8/CFl74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYchBhUhdBvFw2z2wKMxCQDH9qMcFn7ZoBgRqRG2lfOHS+gE3s
	nicEAF9xb3OYCXO9uCvex5UGv6rkQHkq1Isxq8m5X3aRNd+VroJRsIpjrKCHkhBVz2o=
X-Gm-Gg: ASbGncuLnSNvz7yg7h7jKqY3lD0e3Gbqof4/UdStJmEQOR5bc5bnq5sLlB3bZxhSzlI
	4N5Jhg+ayRYbFi5DhrTKMQwb6OTrk+7qoFM+VmFDMKWpgMzb956awNL83/Ak/Hwqn13U0iCLmP9
	yGanyCMbo+xuTY8I7qoNckHc4ibMA5opSW3vQtTtZIEM75kaMm80F6XthyNIch2nDHBZvc6lOnf
	Q9EBelw0E+TlEIUp7h+xLo+arMcs8/2wOduFeS6ZaL94qfoscK6m/2iT4bEffBAsJmbo7P2TyR8
	FsGzCgEApoMuSMu+D4q+E+/8tu18DpLnxq/pLbT0RR3lXKjRZ8ze2K0kJLJOqFvFcBD3miXPHlX
	iaatFBmIf/ffO8j1d+EiYSZtEI/93rf649g1tscF/DYyF0mQ1x9UexHG+BQtRsLH2uLBxecPoGe
	N+aJ7RY+vSpynUK9LMBjkLA5RB3YlKPuNAyWgcosXGZok=
X-Google-Smtp-Source: AGHT+IG47Jfs0++8lUpVeSVSV3SoIwpIc8P5gxrMy8RFysFpxvUaPb7fzxEPRj0y0D99gnOCvjvo0Q==
X-Received: by 2002:a05:6a00:92a5:b0:781:1a9f:2abb with SMTP id d2e1a72fcca58-7a220afeef1mr18606220b3a.24.1761032785740;
        Tue, 21 Oct 2025 00:46:25 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff184basm10575094b3a.15.2025.10.21.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:46:25 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: mika.westerberg@linux.intel.com
Cc: andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	guojinhui.liam@bytedance.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] i2c: designware: Disable SMBus interrupts to prevent storms from mis-configured firmware
Date: Tue, 21 Oct 2025 15:46:19 +0800
Message-Id: <20251021074619.3638-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251020102958.GL2912318@black.igk.intel.com>
References: <20251020102958.GL2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

On Mon, Oct 20, 2025 12:29:58 +0200, Mika Westerberg wrote:
> > +static inline void i2c_dw_disable_smbus_intr(struct dw_i2c_dev *dev)
> > +{
> > +	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
> > +}

> I wonder instead of this wrapper, can you just do this in
> i2c_dw_init_master() right after the adapter has been disabled?

We can do that to simplify the code. Patch v2 is sent and has been tested.
https://lore.kernel.org/all/20251021072431.3427-1-guojinhui.liam@bytedance.com/

Thanks,
Jinhui

