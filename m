Return-Path: <linux-kernel+bounces-829203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AACAB96831
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF7818A12D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26D25A34B;
	Tue, 23 Sep 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YJkkLh/Q"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47722C355
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640380; cv=none; b=usOQTi9TQypXV5vQz98b86gVUozEBD4fh3K1LpBIwAAZNX/elPsfOpo72x5M+sUMFBsZzISV22ZTfW8Poc3kptxgRTNa5+vTH3f1LSupsCWydGoCAT89j/1TyR7dmm1Zo5UNWr+fIbyrcNMSqLPdRrRNJTDm74Zmd/tI2EwO3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640380; c=relaxed/simple;
	bh=aEgUWgJ0RihK5oqEy2Sqh/7xnzLQ7c4nbXXy4s+OdtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaTecDzAAIFLhwDLGPzwHvJc/YOWRnJJjMmwXkGsQ2LDrZ7dr3Wg/1goFg/mEUjnlXlEVZmUc6NtzAHJvhbxn3mcsPCLwBMHHcbIktSxJWVQACKMP2CmOED/xlawiIuzFQhTU6zPINZJuJrYhGrTMec8j9/NZDW4ieSV7Z8J/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YJkkLh/Q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b2fcfef5600so160314666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758640376; x=1759245176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SK4p91UquXYpcDOvla28wbpzx/0eGA1LJALNz7qAV/A=;
        b=YJkkLh/QPJeze8+RPJiAK2dMEnwjsUTvPLacOhx83ZCPcpquxDq/RNKoJg3AFMptOi
         lA4qYtMfXuVtrnMdFAWRJxyi90hl3tiXSegbYmMGc/ldp5BM41rjb5rTyBY3cBkiXriW
         uqHSM8ZMIVKL/CqSQFH+wRqBesy1i3GxWfV2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640376; x=1759245176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK4p91UquXYpcDOvla28wbpzx/0eGA1LJALNz7qAV/A=;
        b=EazSmUDX+jAFHX+2PaFl17UEt2IoVVStBDfUiqdFI6r65r5DpR9EDPtKhvOQO06rIG
         TyMy+fzosfJ3Ae4JbOG5ZnSkXkD5RiAV0hcqPj6X2XUQG2eLZfdTUyytaKEZzeXNs0QP
         kqq5lDMgPTHCs7lu3tpNiMnnfqwtauKoWM/uOiwxt8SDi+FY/7bLwnE72DSJmYB1MOTM
         PR1M3WkHfKkHt8yRpmBvR0Vr25MwoaZMxzkhzNtqsGcXLIoD7xJbywqKE0k2U2gPqyam
         OdAtyWRE9wrykJVFuQS3odpVxfL5UuV+0uo+O5CiMeD860QlcvKE4svtvjLjgYcgJtfF
         mi7A==
X-Gm-Message-State: AOJu0YxJLVoFo5nwwZp2YS9kDZ57HNZQjFi1D/Di262E9BAUd5xjB8zS
	aufYZINqNt9qqePntsHd33H6Nv+d9Ic17pm8u+fpdf6Fh2wyVXbgLat+W5FMvj+vh08ZvoAiHKc
	XjIYcJe0=
X-Gm-Gg: ASbGncvZFMCEBezExyPpvM1ArHmthoo15W7XUOhN8JdHOkaobalpCiu3hWZrD671zM3
	uVvd+PL4U30SCH4OI0sYrkpYk8uXn3H6URsl5IROCj+aM8RlIK8BfmcmaWm1+QLl8rfXVbH+L1m
	81imfYylK5L9rJ996yb51BRfh5WO2yYgzA8lX6l91PhaOfalRVHW+I9BJGZg80spO2luFS0aaJ9
	auJPDMG7DWXTdAXJD9/8VXJMmrGQlkFAddjOtH8PLP+BvQFte8XW5KvQn49/6KjQKNa1wkdX1mk
	IygMRpVxxaX1OB1XHB32B1mT5fE7Yc6PAq4+XrcUauUvry3oGgcmJupTrRvbqRO4Nrl8EpWAJP3
	dAbRhLyjwVn7Pnev8LJz4OHIks/p389JStnZrJo+cLD4Z2KP3hCZVt13gWx21c/Xe6LZNyR3C
X-Google-Smtp-Source: AGHT+IGv9FQuVELYFXvdt9h9DYoghhW7MkmjEapEIc9eURXQk7eJPJ2VDC93vzVR4eM3+s5dWPk8rA==
X-Received: by 2002:a17:907:980e:b0:b04:9825:bd77 with SMTP id a640c23a62f3a-b302b80a6b1mr254571766b.55.1758640376497;
        Tue, 23 Sep 2025 08:12:56 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa883sm10774413a12.11.2025.09.23.08.12.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:12:55 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b30ead58e0cso114163566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:12:55 -0700 (PDT)
X-Received: by 2002:a17:907:6e90:b0:b04:25e6:2dbe with SMTP id
 a640c23a62f3a-b302c1fff60mr269464766b.63.1758640374544; Tue, 23 Sep 2025
 08:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
In-Reply-To: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Sep 2025 08:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
X-Gm-Features: AS18NWDtCTHbiHptNh5UG7Hu3DSC-Rv2WM_knZNQ2TEGm6B2SDsTgkz_lQHSUwg
Message-ID: <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc7
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 09:49, Tejun Heo <tj@kernel.org> wrote:
>
> sched_ext: Fixes for v6.17-rc7

Oops, and people point out that I have renamed you in the merge commit
message due to a messed-up editing error.

As I removed the "es" from the "fixes", I apparently also removed the
"Te" from "Tejun".

So now you are officially just "jun Heo". Sorry about that.

          Linus

