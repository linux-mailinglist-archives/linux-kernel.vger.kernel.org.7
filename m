Return-Path: <linux-kernel+bounces-845765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D70BC60B2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426CD19E2446
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9462BE7AC;
	Wed,  8 Oct 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPIIeUxw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66672BE056
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941512; cv=none; b=rJNZHhjqEcL4KVPgJhLAKry9NyE1BzsSHkK0/t1AgIubV/R49rENnEcAdgy380gGKjyvm6E7bjtesIRMde1wDz4KSFaNpFmmTgSCoFIRRrdqwU1JtGJ2lDcqT9w8drZGwRP+i500ulD6Q3ETzh6FolOU3TnNoRiTvmbO/nu7sNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941512; c=relaxed/simple;
	bh=GHWooLMWFQpFYOeVJKbxAuT3hNdbnsUChPxjCEbkMIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko5TiVF7OXlcodU8QRPvyPH20C6b1sMs34nW04EIAzfo85iI4EcNYgXdyvbw5bcLLJdXIgFss2vIH3gMERb0P6NKnDFD9KE1MHE7O8gDJPPoN6KdAb8+vawcJv7DMg+XwI2SJURWGl1ScnxdKQ51D7toC4DHaSp0x33PuLFITkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPIIeUxw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2681645b7b6so219645ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759941510; x=1760546310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhHoNM7BdTnfoFMXEJIgA+2SvIY1LJRe/Bxo4/DQQok=;
        b=OPIIeUxw4mi2buEin3WKqZQE4zTUkA39VWft/En3nirwYjmreoyyLxwe7rPu7BhgPa
         BCqJyeOwGH9CvuH476rnnq135bYokIkInhnSseqklmKGvT4BWrSPZpCVcmqIf4Mvql7g
         +B9FpXbUiW0y7+GeydzwN/cRTkg5xyObrbbqwqaIUsZ7znzahgH0cbpUPn7LG2Mco3UU
         7sMqJSCIDSwNLsWLRGhXK3bd4su/iUjinEYroByAUguzc2d6H5BP5MhPjt0bG7lNLDhQ
         u5ZUKq74sSeq81/iSPgDPLmavPC8ZjIs3sL8qnoMSqm+1Wy28DIYhs2rFS6q0ajehgfs
         DktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941510; x=1760546310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhHoNM7BdTnfoFMXEJIgA+2SvIY1LJRe/Bxo4/DQQok=;
        b=TozCs1F4ASN7oRKE4YFUF3oF77pjCOMmGNxN/4Om9K1fgC7FymZwwd4NClC3MOeOnR
         G/+LNVbvAwQD8DrZFVGSZ46hR4pzZ+zwJmdRqhgMvgEtUcRG49wn3GxIFe6C4m63fDtL
         QGi4OyBeW6PzhRhW834dymmbz9//POkRfkmncTJFFdXdQJpTZTJSaUD42BNFc9EzdLwu
         HT3Es2hDTk0xYyfd3uaa1CohW2voIM+rrTmz3feCszdyznIF0k51lHLIE2bodhoJ3uKQ
         SfobCKYfxLZGLKDOF8enpqHVI/55VW6qXXE1BU+XxfCy+KS6skMF/scdsJksEJR8kKVE
         tGrw==
X-Forwarded-Encrypted: i=1; AJvYcCX/uhvelN2lb+1yCPONl52/GddfRHL07g1SlfWqUc1Gq7bQfXNX4xpQVi3K5OLp+QpA8ik8p+S+PINpjdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3lhniU1tNU8exVluQSXAiH+B8yQ2zHoetmNLO3APxiGNNO5z
	7XwsPC4xwAzjn3seMQW1NyxWDMmtWxQ9PxM1k0TN5caCqJNvVJ2Jr8RG0yMzz3xjfw==
X-Gm-Gg: ASbGncsmtPojMNTsOyo2lDlzsOmh2ZEihcEFlHYNzsGDCNBOhkZwfc3EVvoC3XT0lH/
	vdkh+w0hrMtRkRttS9F/rZXU3mTSZviwt5fBtZ5xtUMiJg3xbyEQOEkQ1iIfh/JeDc6BKBJE+/L
	WxNc7LjSSO4/I9lD7eKyhM1YJ8dxn/4GrClV6mqRMxay7a+BQ2NcQPk5+vx5YeDv9nRlksMwYZc
	aRYBmXCXHCGr/zbAzZU7KkHUzgoEjT0UbiDbc0mIkm03hiMTDA+KeJSUDixQH0wGvn4j3Cq9MXk
	bi65JUEnKeXK0iGJI/ceKGVFSor2iS8GW9XwaF3vvgwA1Sx06rW6VBFFalNLdS63qFY46C7/Pod
	rzQtnn9vMrfgSUqVrQSP0oYm+vKJlD++p4JtAmNAlJElGbDheky7ZMqTZrNUTKyq0GiPAG/+rdG
	6Zgr4PYjHitGR/0+mEWKZpCpfcX37Q+uXu6oEE+caCoE6W0v/H/GLIlMDVH3JLafRcvUBeIfbeE
	251P3I4O1rP
X-Google-Smtp-Source: AGHT+IGRDpEomZWgPBqyU9u790g+kBQTaK6pVB3TmsXBhOElsAAwmoOekWMwKi8oOPtX/rPh4gpKPA==
X-Received: by 2002:a17:902:f787:b0:269:ab6b:5bba with SMTP id d9443c01a7336-290276f92cfmr5965515ad.17.1759941509214;
        Wed, 08 Oct 2025 09:38:29 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4a431a8sm215408b3a.9.2025.10.08.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:38:28 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:38:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust_binder: freeze_notif_done should resend if
 wrong state
Message-ID: <aOaTgDMY-VvM_r6m@google.com>
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-1-5376bd64fb59@google.com>
 <aOaSA0dPnY2I4a_D@google.com>
 <CAH5fLgiChj29SbwN-5vHhCNzaUa7wewOXe1D8mN3XFfyZr33gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiChj29SbwN-5vHhCNzaUa7wewOXe1D8mN3XFfyZr33gw@mail.gmail.com>

On Wed, Oct 08, 2025 at 06:34:54PM +0200, Alice Ryhl wrote:
> On Wed, Oct 8, 2025 at 6:32 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 09:39:51AM +0000, Alice Ryhl wrote:
> > > Consider the following scenario:
> > > 1. A freeze notification is delivered to thread 1.
> > > 2. The process becomes frozen or unfrozen.
> > > 3. The message for step 2 is delivered to thread 2 and ignored because
> > >    there is already a pending notification from step 1.
> > > 4. Thread 1 acknowledges the notification from step 1.
> > > In this case, step 4 should ensure that the message ignored in step 3 is
> > > resent as it can now be delivered.
> >
> > hmmm, I wonder what happens with 3 threads involved where the state goes
> > back to the (unconsumed) initial freeze notification. Userspace will
> > probably see two separate notifications of the same state?
> 
> The way I implemented it, the work items report the current state when
> the work item is *executed*, and they do nothing if there's no change
> since last notification.

Oh I see, then that means the 2nd and 3rd notifications would do nothing
as the state went back to the last notification, correct?

