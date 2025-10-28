Return-Path: <linux-kernel+bounces-874114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95293C1587D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F821A2496D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78538343D89;
	Tue, 28 Oct 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBb9rYMJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E1225416
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665870; cv=none; b=KljB0oJNbJGZcms8Vn9Q5pm+9shz03F8rEg5DFtaIsO+hiZDPnAdg3RM4Ish5UY6LX+WdwDPG2x0gIfSRIWZPLgqaCdOZqWhzkKIgZP9YPe9DVxqSDnaDF4i6gEuui0rHl2l9rfwVHv5s+waj56dxAjlzv0pHsJCIuEDbKoqLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665870; c=relaxed/simple;
	bh=hkxftgZogT+NrML8v/Ks/KEOR/YUZS/UiQYNzdbP+u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8FkqiGgkJHDTLFXl9oEU26IhO0x3J/4JaYVH8QTK/i3dR444GAz5hO+yh8JNo11uU/bjxNnkZp9OHuse1g63oGZLsQ/Um9X5yVTioNdmmxiVygUrzexjf/004rCpIfFeikZpD8z6hktd2tlOUBEMkHbKtZwydAM+qqFgz4gldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBb9rYMJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so61411845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665867; x=1762270667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ary74Q16PuhBPSjsrWRBA9VPLl5HYwYWAzTzc3x3IqM=;
        b=DBb9rYMJOXxlJyM+m6BXNSpELSoEt/nChqopUq4uC9Qadq1AyVYSyD4fQzarAxmENl
         0BTDuCvadpxWY/wlwJswFHecSRbrAjnyy6b1WcxPi1QZxWNaTmfIOfc36mG3l/FvMIfC
         aKcue7BmGO5Lhq/IBOeqU4miqQ7kQPUCYU63jMzH5wHYb9AGhSTIr+EPqwHLaWZQTz+D
         9oqXgtmnbbI7OhS/TDebd4m5oExs+4i6ZLzxLEZOXy7b5LI396sx/XWOi55epWEL71ff
         d7N0qzLayvzWatOPMQPfI0Sow4PN4aMRKZ3SJp9G732hpBb/PR1TsJE0+yAFu6JOUf9c
         1BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665867; x=1762270667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ary74Q16PuhBPSjsrWRBA9VPLl5HYwYWAzTzc3x3IqM=;
        b=XXF7XWrckzcxnK7IAtY3pJOBPoqZACPrzNgNHgfR8jfzc+KkS0kLAG6k65vpy0Ni13
         xO789hJVetGXGf5c0I6qrBJuK24lW70igVNqnToRRbiBpyXFX/McDM5mJqtzd4xEPUY0
         /qW1pOyf4+WPEFhJ5T+dl7W+NLGEJlbC5+n7hmPBhbCUk+VSKcbafuK4OMojL9Ku/qZ+
         HVLKE5iC9lrPAKt4hxQ9AonAhao4QGyip/NrpbfvS9HbB5qlOWsf+e3hfXakrVDzna8r
         934Zj5r0iLL1tBgQjqatutKbejkDOkV4Tg/I9Nd0eCdqILLK0dCEqfwmMg7EUIyzHkHU
         ScAw==
X-Forwarded-Encrypted: i=1; AJvYcCXuQTAgEYeyGaZIJ/g8Y6648EjvCMgsfDrfTA0mj8n/NG1Up4YN9ft4vf7j/AgQynJXPxBYxWVJbmauo8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRDKsdNqVBr+igmbIefrdjzhffOQDQQzo/yAUG6Jud3Zv4rSz
	X5T2cHRdwdFbHG0nWCAA0b+xJ5nhOKGtDmwFWt+wmv6AiEQFehytDzmwFuCaxygc7uY=
X-Gm-Gg: ASbGncuLCg5GSYhEnq9lgRugIARZJhkKc1GYHbPU99cbFKnmbi0qDO6yZebi+4UWBj5
	mmDqyGIovf62Q4wpPUDAzs8DgKrsz7MtsZy7dyrPQTuGS7ki26pZ9XEAZRZSJY/mGJbPLEpVlHO
	BbhLLYzDp+3LGiP3sNrhPgpn2oaJC8xidu14/y+2VT2jGiNkh8BFmSR5waCH9kMep84AVYUxYnZ
	Bs+jSdS6yYWWyq0j9REoGfoI+dHjDPq+NyxgOoR3Z35aE4aNwtH0DA9Q8u5B2F9wARIBO1f5dtb
	lFHo67CSjCko20OGMGGnQ77OdntTksCMohs4YvAAOQLlFSAXrb/gJkH8T5aYlK3xkM/rn2no/YM
	QgZpyfRm3wClK/tN+ZtSMmClUC5sGmMeEiH5HgV9KbMEcyWlUNgQIZX4keQf7RsIC3Qnx03Dbt1
	3Lh+B60bI=
X-Google-Smtp-Source: AGHT+IGa5T0vOPwrqxsDiAUoacPyZz4CzqIzpe6EkXzz80SQCdnOeksixDrdaFnDHHVah/KpxoMYOw==
X-Received: by 2002:a05:600c:6304:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-47717dff4cfmr30922465e9.12.1761665867365;
        Tue, 28 Oct 2025 08:37:47 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm20595813f8f.40.2025.10.28.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:37:46 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:37:45 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Skip setting orientation for UCSI
 version 2.0 and above
Message-ID: <jworx6dkoykwimfn7b3wlatgvk6engrbzyuhzsqbgjivlpicjw@xg2aenqcwkmz>
References: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
 <a4f3yhhz5sntno6gnfbjnjjsbtyo2e4y3da2aywsg36gvxkaxg@vw2vryukrepl>
 <xboq73zw752odclybviqnl75pp2nl2eamdvcdv2idqljck7qvu@zdh6ny7nja3w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xboq73zw752odclybviqnl75pp2nl2eamdvcdv2idqljck7qvu@zdh6ny7nja3w>

On 25-10-28 17:30:37, Dmitry Baryshkov wrote:
> On Tue, Oct 28, 2025 at 05:19:58PM +0200, Abel Vesa wrote:
> > On 25-10-28 16:39:19, Abel Vesa wrote:
> > > In case of UCSI version 2.0 and above, if the orientation is set from
> > > glink as well, it will trigger the consumers along the graph (PHYs,
> > > repeaters and so on) to reconfigure a second time. This might break
> > > the consumer drivers which aren't currently implemented to drop the
> > > second request of setting the same orientation.
> > > 
> > > So lets leave the orientation setting to the UCSI generic implementation
> > > for all platform that implement UCSI spec 2.0 and above.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > 
> > Ignore this one please, as it is incomplete.
> > 
> > We need to also set the orientation_aware in pmic_glink_ucsi_update_connector()
> > if the ucsi version is at least 2.0.
> 
> Note, I think it should be set in the core rather than setting it in the
> driver.

Yep. I agree.

That's what I'm doing next.

So ignore my earlier comment. :-)

