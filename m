Return-Path: <linux-kernel+bounces-792149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544EB3C0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7DDA64254
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E203314C6;
	Fri, 29 Aug 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRd13MX+"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EF321420
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485086; cv=none; b=VZxV/pDbcZeoXoZe3sh01kPG1/aW6Bl5LbIPg/GhidiXjQZZinB7GDrn4q8Sreik8trcDrHBA7ZJkzfTaq9jBG3PrlOYjd/XGq7NxjvIahasNLL3W2F+KscUbtOgzOLKcc9akDCIQaZoc7Lyym/QNhugmElJ7na9SWCvb826h8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485086; c=relaxed/simple;
	bh=pHyUzdGIEuMbKyrMh+j6H6WX/5fl8Lbl5tqXrks6ehM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHMhcoexFz+H+rdPbLZR2T2ekUqKD/JO0CMcgDkeRJK2XcT+V72U7NFamQ+OQwq8bIe5M+53Uc3KSFfgcxyR6D3ufeAaxYikplASk7FVtAq/s+jVnvKN1WduisI2wpkQr7O3bAyTKDppH9a1byVtnjxeNekqtE4CjVbMT/DttGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRd13MX+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88703c873d5so63697739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485084; x=1757089884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Aq9F6GkDNRj0W5kCY4QlKzlsKBjTYse7H5/E8RG41o=;
        b=KRd13MX+7P+3AH1dA3PWUdQuEZ8rs/th7cksPNkocp07v0xeyyGkAy+3IcJvplUUey
         gZSuI26Yh3yQLilHOzqjiZZW0eOWzDqkzVi9/1JGMq1jqHmp4pIdWA31iY4pBnVC1t7g
         0Tb5xvzZWeW+4vq6MrY+JS/AylEx0AVFNGv7Y/H0CLuYwy+69qRPCbiWbKGs/I2BADCM
         YobVpfstmo+i9xDaXOEkVyj4d7sRQFG3RZ1Ay1DFpsdJyR40edcONvx5yRbfKmqshjlY
         dbjuf5D17B16unQBmCqz8jY3VYzVArhGFHSco2e+t4dHQS/g3Ba5cYH2BrXWDFDLFvKk
         uUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485084; x=1757089884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Aq9F6GkDNRj0W5kCY4QlKzlsKBjTYse7H5/E8RG41o=;
        b=qLmMJIGvwOZCJUJ9a8MzJLxZFnpBuVnegyecgYrPbfS7O4mnqY6qtgkXUg/pHeqlC2
         8+B/EMD0GQEHQuC7nWe5C8ys7xmpmR74T5xOvB+8hjyuEH20PRFCJISVlXJLXO2w7QW6
         sYxYSN0Z7BdEuBRhqmHphd6aj1ibUIGAosd9l7iv8H16dKz4ghNb2e/ZdtNfFaPdqAyG
         W+LHVyJCft6/T8AbaNTz1p5aBiec+X+VzPxzKtvLrt4Flpwgrb0UTiFrFoUrWO+0Tev7
         HxIK5TwxbpNSyaEYETODasH/qn+wYjusCGbC17f3KfT3G19JDUtWJkcmZbCgL5VNnlol
         iDtw==
X-Forwarded-Encrypted: i=1; AJvYcCVtVtOpASSmW2yijbJz9hBax56KsCeAxq1rsLqt4TOfZVnDgODh8WMf01BxMcMxBOZxqPBUfe0Z3dPQcTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbL1ZtqPzIMSwPJhu8y/o16ZGwR2io/hJzbejyjc/z3PVh4cc
	gkGFHO71CJJXy1mm3mHckHJq7diJJ8vUqmLE4oqfqAgcdlw36IfZNtVwaGysLox1c8GeKBI3VzL
	twDtB/9RX
X-Gm-Gg: ASbGncu+ON0+6wPgDrV0iI/M707Vmop0bZPc4FiecPcxrf4nYVHAgHa8dYdYtSotKZo
	iBLP81hyfXnEK8cwGDFi2Sgyhf6G+fHCquosASXjClFKI+60xKr4G3SqJM9AFdRxKjWKS6m/ijv
	j+pqmcYCv1T0hvnsuKWC1dEwFZ/2XMu03GidZeNzM+zXYgSdQHz5Tpsq6SMxkoYatBDW0lAhxIH
	Il8z4T9EIaLSQOIdqyag/S3v/3pzA8rozjYx5OYvC8bB5muq19jROXpoT+SSw/LZWapYv+lXNNc
	w7dLx/h74FKjnP8Ee7Xr4S9AYG7TUiaIK4/0e7KwhOATN+iGUw6yMEefLx8QOG6YzepsyMWvz+s
	piCkOQp09GszLY9JBUuesx/u9r9C7B438ZwwmO2PXz9ClY2xTPoUaH/MtCyxcR8+7Xw==
X-Google-Smtp-Source: AGHT+IH8g3k6EVCj6uu/y7CYnCfGfvfUlntaVdqZjmhIzXo0V9tMdpenbFbzM26tob/Rtwf21Sm4Ew==
X-Received: by 2002:a05:6e02:16ce:b0:3e5:4631:547c with SMTP id e9e14a558f8ab-3e921d461a5mr379924525ab.14.1756485083760;
        Fri, 29 Aug 2025 09:31:23 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f29f7864easm8752885ab.20.2025.08.29.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:31:23 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:31:21 +0000
From: Neill Kapron <nkapron@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	kernel-team@android.com, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
Message-ID: <aLHV2Tb5aw1Znfw8@google.com>
References: <20250828170317.2322582-1-nkapron@google.com>
 <CAEjxPJ7-M5OAiTLmOynP36HF6XmJKhH2kTFAGmhg8ohCkZuT8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7-M5OAiTLmOynP36HF6XmJKhH2kTFAGmhg8ohCkZuT8w@mail.gmail.com>

On Fri, Aug 29, 2025 at 08:18:08AM -0400, Stephen Smalley wrote:
 
> As before, don't rely on the policy capability bit remaining stable
> until Paul merges this patch.
> Also, not worth re-spinning IMHO but the changelog below normally goes
> after the "---" before
> the diffstat so that it doesn't get included in the commit message
> since no one cares about
> the in-submission changes once the patch is merged.

Thanks, I appreciate your guidance on this!

Neill

