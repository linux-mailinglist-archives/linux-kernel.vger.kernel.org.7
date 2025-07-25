Return-Path: <linux-kernel+bounces-746134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087ADB12388
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F963B5D59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754728C01D;
	Fri, 25 Jul 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8PYGoBo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0123D2A8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466830; cv=none; b=IKXiu4gzO1PeWKYHFHTDnCN/871NB8ZZ0akiR1j/y9JbxnRymPGRhHSk93mylVcG3gkEWighGmQywhylV2Z1kTPIt7DrBVmDnZaJF31GYlAocutr7dRsggG91S07xwYsl5JjBiSWZoh9Z/Qp3poT6uBmGnUBPrSdAbR73zbsqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466830; c=relaxed/simple;
	bh=uDBMbjG9ra7NtXRmRVwfUSvMboJFJpEx41Ab7xMwcRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou1oD66OkAWqgoaqrzrFAhSGzTXmcAam9IvFD5BR19IIftKJbqIzduhEKu+F9Okv6lHzT1dT585ju3rr6h1r+ijEyDrQveSWr7l3BfCvGi39KO0RekxE4EZxypcxE4bnntVs8x1o0vNDLY1R8uoh0HUnuyZQtHIw4OS1YZi8Qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8PYGoBo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso20895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753466828; x=1754071628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axl/Upysq1imNPEh2OI9EDM4ev294X+qNbv/okR0n58=;
        b=r8PYGoBooSdTG6IiqbcxXJPp10Xottv7+GU0sAoMy4lzJsN2dHr1eSAYR9Dnqp7Ovr
         AzU+uRRApZLMbJ/b906HDIXl3bt2v/hvRdvJlLIlFmgoHQLYuD26+pEBL8m9NRKxVLan
         232aps92lw3796XOfwFKDvdGdf/CMnNSYEgH+w7du6sMvxa7h0Kjix/BAEbf2m+Ae2CU
         V+/1uzJgpNXF98HHoZoo5/98yRvSKEjdOebBUjcVgPc+7kph5GjLDejLxWZv/mSs/lb7
         SQQgvmBM9A/SKUfY6pc4fjeI3cq29SpwFgBHKjbPkT2xLgiqG0KXdnIMnpAYwbOA/hdE
         ws3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466828; x=1754071628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axl/Upysq1imNPEh2OI9EDM4ev294X+qNbv/okR0n58=;
        b=a3LFKYzam8e4qLvO4zLQyFJL7rB8urrOU1g6RYI/fjF6JAcO5Jg14WsXfP3kI3sC3j
         2TjkAOWG1O3+Tifecf2sS7Tli2KcGb2SjNqD5KSAv8NHGuW4qWzMmBT46pq/2A/EZpwL
         UX+0n8YQYR+ln09dqzMnfXEso4SlZ23bpRXtLD783XZRvt+9gUP6DLlQe8OrpJA1fIuT
         7yvq50s1hLLwXh9TdoLNMveASTZEMFWNq9WfVsnz8JVN2Psr8iGRUdAvI8zDz2/mJSGH
         +8b7MOmwGLO7ULGH+UQRcxaFrk9SfdibSO/mIGiJ7Zq+hvRVqFqw9PXt2RcQ+mZydDzR
         FT5A==
X-Forwarded-Encrypted: i=1; AJvYcCVF1LPkzC/wIQymwadZRG4o0dt5mxEkXvDG1/H+cg/tdBcIzP/xqC7x3G6rgXMsPmNUctFGLerBPprtOb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlcMHLP0il9l7rZrqc6a9DbUlCmVikYkazwrj6zO+KnHBNlri
	/NVQrq4zflCWTuHDRvgP9eVMB0oHNyn4IjLs20fYhCzWReDZ35D2xSfRk6GVjjkeJw==
X-Gm-Gg: ASbGncvJqMndq00GWg4Hxy36UMeMQDOKLrdfjjmMC9anO8I48em2O5QGSl4tdxe7eJA
	BC7JtQYJs9bCutV//QlylZfz8i+ZPTM++STCvHils6eeZCTwhYcPrt1/wzGUJpN6tJW9LN2xtaL
	SmOhJjTJFRrki3cwYTpnlWnC4n5WT+TRFYNldxLycI0Luh4khxj+btiWIzVtphMom1JCtSn2Zgg
	DQJ270i3McQybhsSC+nKfubqJEP39lX+Suvw2LsFQ9pBxymaWrjzTyiIo4ZL0YThepY//nFhgZn
	Gjct3WHARJZm8VJE75Ilfx8UNDNEdcEr2eEqZT/sS4DvjJukp4MZXXclHxGvZimgQtlKWhebbjM
	nRqFJNQDD4ENoW3CccgJpMeHeM1+NXbAz03a3wIyFsqEddRRsLZRryNLa5xRpGug=
X-Google-Smtp-Source: AGHT+IHjwe2gFYKYnkvseB2wuhGhO+XXYs2y6bsFgbqHX+OaOm+xTpI6Kr7srgOaQZoqEem2i7niEg==
X-Received: by 2002:a17:903:3293:b0:235:e8da:8e1 with SMTP id d9443c01a7336-23fbfd106b0mr119335ad.18.1753466827623;
        Fri, 25 Jul 2025 11:07:07 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b063csm203175b3a.122.2025.07.25.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:07:07 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:07:02 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>,
	Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>,
	Shai Barack <shayba@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	kernel-team@android.com,
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v18 3/5] binder: introduce transaction reports via netlink
Message-ID: <aIPHxlM-hwTp32sg@google.com>
References: <20250724185922.486207-1-cmllamas@google.com>
 <20250724185922.486207-4-cmllamas@google.com>
 <20250725103858.109f1c5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725103858.109f1c5d@kernel.org>

On Fri, Jul 25, 2025 at 10:38:58AM -0700, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 18:58:57 +0000 Carlos Llamas wrote:
> > +++ b/Documentation/netlink/specs/binder.yaml
> 
> We started running YAML specs thru yamllint since the previous posting
> (the fixes for existing specs will reach Linus in the upcoming merge
> window, IIRC). Could you double check this file for linter issues?
> We use the default linting paramters, no extra config needed.

Oh good to know. I just ran this:

$ yamllint -- Documentation/netlink/specs/binder.yaml
Documentation/netlink/specs/binder.yaml
  6:1       warning  missing document start "---"  (document-start)
  91:13     error    too many spaces inside brackets  (brackets)
  91:33     error    too many spaces inside brackets  (brackets)

I'll have a look at the incoming patches and will fix this as such.
Thanks!

