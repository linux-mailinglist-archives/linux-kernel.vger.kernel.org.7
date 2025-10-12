Return-Path: <linux-kernel+bounces-849651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C029BD0951
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFE4E8891
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26432EFD95;
	Sun, 12 Oct 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8oxZITE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DA2F1FD8
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292447; cv=none; b=U4AhO1jKFrBCXbZuY9wXBrN/2VcDEMm2dd7+Ke0EF4lrKnw86cy9Y7g91MiCzQAj6PeExwcov4mvRd/LViq0MhaTn3rN7CHQOzCJpW5633ffEoGoAd752VkXnLjO3mPP4NHW7/XUi2fZM/29Njty/Y03tzI8XRFQJGQiAz3p+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292447; c=relaxed/simple;
	bh=VYct5uqgOuBPtnr/agOuQUfGSRixsl50ArqFin74dUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuXUpHEOVh6Ak6U7Oqg30FPjcn+jtmBz82CZK26nJ0r7dwuPLGt2YVPvrwr+ksRxLk9/uvehnbgfwUDUN0MfAqBSGvJhCGN8BSfqTA3Cdw4OA9Q905QInOqlJOZxNhqQSjH8G1tkLKOTKKm0a1GsTzdTHanUQi8PcLURdU3LDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8oxZITE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33067909400so2624798a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292445; x=1760897245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7i+q+CJzc7d/v15V/dcB6nP6r4+CnOGrYGYF3/B82s=;
        b=a8oxZITEoFTIaMs3sUEN+J3AuMfdkq1Xix0lsXac39/6eTdfTcI0cNYUbeMCSCoqKq
         EzRWK36qM29yzLB8SFQYMEYo6HIrMGeKiEjxWQeLMqB3Hf0Z8v9rv6CTVY1IwcjKjh8T
         ykElsKQUQLclS+i+6dfQ2Hlnozik/ng0EHEoQjeEO3f0ttIBXsnMD72SDD1Uhzr80fgo
         Hlpyn7+cDN2GWxwS8C6wM1NLl7bCT82yUo41juHk1G1E9Jg47K2Rv2+2iUZKB/zwddAS
         D4tINvlXNy68bEeTwZWgi+2MhogCQ76h6kBeCDb77wpNSnLnTmI/6bAqAj8MKfJlpRnt
         Fekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292445; x=1760897245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7i+q+CJzc7d/v15V/dcB6nP6r4+CnOGrYGYF3/B82s=;
        b=J/oNGDl420TjJzEF3z4Hy9/5sjDRXwRvo3g/pX7sO5A1NzsRNUTG+LHURwf2GFyKbV
         7/iGcmP5OHHG2dEnYoH6PkrShcav9WQmhBV+7Kn7F1H8bxiDQ7595HIhqKp+2TMEWSGG
         IJwKo6fsidf+/Yw4JcgBJsZKRguSUEqgZXpflAlclSemYw5ztVC/AsylKMcR51s47UsN
         I4X8/mF2v78FXhp5hQ6w1DWzE/+/Sb21oQomluArf6RKCuJZ2r0IiK/+CQTyOdZGWPmC
         yAzU3jEvZNFeJZU1CIkmyaXj3dDAR5tsR/p/aEryKXKRajVmhJYv3VlppZjtYNlAqP/o
         lU3w==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4dIIdMPxjFXM+pkRdXjWSnoakSEmnwsN0FzcqDINwGUTnwvJTto4u9X2UmcGPVkDZe6Bm9oCnPSERZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8x5u+4XhhPotO0euVfJb5ARnYrkrDpcLiN7TM2VBj1kJyWkQ
	vZHShxl+FxBy8Gb7VfI1wxQvsxI9UkL9n0ZM0XcJlBtIZkLg7ahb3YBY
X-Gm-Gg: ASbGncssMIESsoekPrJaUezal/TN8ie4f+bJXXFKDroP0YSvx4y40Ho5O4RpjoIq6m4
	CIA7r3EKi1mpK9EL7Ep+7joZo+leTHndp+wi3eQb8BCqJGhAzON8Sw4EGT2+XPvShYGhE88WPe3
	yohUQjGz8lIER5s2xYiDyX8SYxpfR6rUMa9sA/bFnJ2KJ8n19GpKBOBj8Dnlvcp4xSiAAMTRCz5
	rEzo/EuDdMLgcWytNyIa31DKERHDkjVI3MUjbsnB8v3W8teoOKVKdNaf+Gx528Tw6oBRsK5cjUT
	d2UxCe8v17EPnHGd1W3yebADexobuxVS3i2BB4iP1CwVMkv7VujRzeoyKuHCbqs6bWdS3OdOgzB
	BTM975elzmMnntok7oDal3ddKedTkWbQ+W+aptSt2lu+5BEqxxF+BVg==
X-Google-Smtp-Source: AGHT+IEGrnByCpct5tS92VZPaK79GTSVnUDzgOIkV+hPgZq4ya1QY0ZSwDjmPxxTVw7TrNKsMHNs3Q==
X-Received: by 2002:a17:90b:4990:b0:338:3b73:39ce with SMTP id 98e67ed59e1d1-33b5138e3a7mr25400722a91.25.1760292444891;
        Sun, 12 Oct 2025 11:07:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d386sm9672026a91.5.2025.10.12.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 11:07:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] hwmon: sht3x: initialize variable 'ret' in
 update_interval_write().
Message-ID: <e2ae44a3-b3c8-4f90-a180-c619e1854317@roeck-us.net>
References: <20251012-my_driver_work-v1-1-9e5fe6de51f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012-my_driver_work-v1-1-9e5fe6de51f4@gmail.com>

On Sun, Oct 12, 2025 at 05:13:27PM +0530, Ranganath V N wrote:
> fix for the smatch errors:
> drivers/hwmon/sht3x.c:606 update_interval_write() error: uninitialized symbol 'ret'.
> 
> The warning can occur when both the data->mode and mode which is
> derived from get_mode_from_update_interval() are zero.
> In this case, no i2c command is sent and ret remains undefined
> before reaching the coman return path.
> 
> When both data->mode and mode are zero, the device remains in
> single shot mode and no configuration change is required.
> In such cases, it is correct to treat the operation as successful
> without issuing any i2c transfer.

Actually, in this case, the code enters

       if (mode == data->mode) {
                mutex_unlock(&data->data_lock);
                return 0;
        }

meaning the problem does not actually exist because 'ret' will be
initialized if either 'mode' or 'data->mode' is != 0. That means
the smatch report is a false positive, and this patch is not required.

Guenter

