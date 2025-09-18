Return-Path: <linux-kernel+bounces-786032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B1B353E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD3A1B62E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7142F532C;
	Tue, 26 Aug 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vin/+fWU"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07452F39C8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188656; cv=none; b=PYJkQLHgNzXUr+p7BVyppB+dfACjS+ADek6LVfttF7P7hsediw7NPNkcczocGq4UasQx70tE+wpZK9joS0bAG5u7JOnDo5kajskdiXYkefJnlkxKVTRtDNjDMeVpTV/XISJRsZFPIpYqibepJWdB12SOdLhD/wqd8O/GVmj9m/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188656; c=relaxed/simple;
	bh=Ox8RxDA3bNw0ju+IxTT5l8so3r9b/ke7cdZN2luomdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5aJoNVMDlhwc+wlhLHKeQVinWr7xT3jNiHgkwMqigwRFpXCgVgffBKlftfprS+FZfejT6/xaiDi8eKk2cdyvVjLey9wD9Q6pQ4lfcLN7qF9P9Dnevi3AD6kzmmXpNCvFX2bzuH34NIned5a6p5nSNSEbcaJuhXdyGU50pQ2hiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vin/+fWU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49d6f8f347so2202994a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756188654; x=1756793454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPbEQih3xx2l87u8k9DIANleeYvqxDGBG5uafWJ6KQU=;
        b=Vin/+fWUW0wy/9oNLlniY2V5JNndSk+i2elNpxlIbflq9aG13fi9mb1NcPUqx7SL/k
         PtskTIDoN3J33d6yqs9Jm6LUOy09tyA9j5EQ1faeEMegAqvH7t/yCkDI/wWqtp0O9A31
         MEa2MOwdSlzmeLgjQ3gRN9NQVP7xq4pyuUwsUOkhtACVw5smR3fyQDZHnN1V+vEWne+3
         dR4ioeBhb6nCe8E50B13bwxOfxdlm0nagBpF82Kdswc/d2QZf6SYyEpbqd0gj6ucIYi9
         h0ciXHclvL7/+JXa9KbP8FbKEuzuQu+1d99nUFTQRUlRM2xDSZctEsrkg6NmBeGU93F7
         c8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188654; x=1756793454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPbEQih3xx2l87u8k9DIANleeYvqxDGBG5uafWJ6KQU=;
        b=vw1g4jZA0+UjkuyzLI6nkbTMWn3gMs5GXBOWIh9c7RzmC/5oslNtpFbeO0QQYWRhIm
         j2i2XQpcrI+Z4Y5FkPT1UwYLXLqGaxxP5gmywEeVnrUnCoezJG1P4cA/7+bbBoo81W5w
         MsLU+CvKMK45wZsH82OtGDVHrJKjVuRTN09mgc14bQmJByqvekJ2c9kQSVLw6EnMSnY8
         Tr8B0t2I8Eoc+jxlD7jk9nZPUTEfUGsnCwzJpk2rPYlVMse0CGHKNHmrzIscBgv+KRhf
         LzLl02bjHvmvlaziafZPOQW17wJPUU5VePlcaqK2XAj6sylGi0K9IcBODIhIJLU3A+hk
         xW8g==
X-Forwarded-Encrypted: i=1; AJvYcCV90Jd7Pvw7u5mqxFhOGcfUZlRDBSBN8T7dQBjZIHMYcP1QriCfoqT7YkTV8uaW4/JOg2tEeg/f/ejwg0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIQyB3pKMDkOeoLdLuL153pQjPuQvBXjv1DULxkkDjmfGtbqH
	8CRp4nh4mF9Svi9YZEJcFGS3phQVnrdykI824aqlHlfFj8zUiYUVAUs7JvLNaVE4eAOS7OqBtIv
	SYnhu
X-Gm-Gg: ASbGncuPFUqTsGATYARQEy2ys8q09oha0BdtAyoKes5an6qpaeYUZCjgvRmwt7dH0Lq
	S5qhSEUeWCh8pVPZnYcxaUZTKgUVj/SzIESSfh7iKUbj1cH6tv8B+o31bh4GuZ3mCCR6e+72OYn
	zqN7v99V++qX3bap80Oz+1Wh85Hvf9id2YC1VGfNKc5aSsf2+BwchBJJfOnEwMFIR1T2TygOqlb
	j6MawnxM9+RVcoDynJnK7Y30v4BxCgpkDVH3kPmbMwom6cvENDn94NtjF+uWmIcIv7rl/02UUFZ
	OE208ic6jvtB1LsffCGixt+stLVuo0luY8iO/xrFBVidKqbFwxNaHkXuOsdJrwpHSrVmLiEKNIu
	eO1tQMzrfaWFhEBn6Xu7G4ANT
X-Google-Smtp-Source: AGHT+IE/R8nkSeTruUQPMxyzoT16FR/AXogKVEXJgDUV7G4k85lb4XdNCGcuKQdLs4LtWirpggG4ow==
X-Received: by 2002:a05:6a20:3d89:b0:243:7243:12e with SMTP id adf61e73a8af0-243724302dbmr8566235637.20.1756188654163;
        Mon, 25 Aug 2025 23:10:54 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c1b2f5a3csm4072679a12.4.2025.08.25.23.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:10:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:40:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Message-ID: <20250826061051.bofm7bxiqviuhux2@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
 <CGME20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c@eucas1p2.samsung.com>
 <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
 <919ea7ce-a36a-4eaa-a13a-c693eb9c6c2f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919ea7ce-a36a-4eaa-a13a-c693eb9c6c2f@oss.qualcomm.com>

On 25-08-25, 21:26, Krishna Chaitanya Chundru wrote:
> looks like for compare_floor we need to iterate to the OPP table till
> the OPP key is greater than the target key and return previous OPP.

It depends on what kind of comparison we need to do. And this this is
how it works for the _floor variants. But we don't always return the
previous OPP. `compare` directly updates the `opp` and so it can be
currently iterated one too.

> In that case the updation of the key and dev_pm_opp_get() should be
> outside as before. We need to remove this part of the patch.

I think all we need to do here is check if an error is there or not,
maybe I am misreading it.

-- 
viresh

