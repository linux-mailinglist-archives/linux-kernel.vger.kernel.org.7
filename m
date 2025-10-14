Return-Path: <linux-kernel+bounces-851756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB57BD72FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DD618A4EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BE301017;
	Tue, 14 Oct 2025 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arh5UfIj"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FA223DD5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412560; cv=none; b=fVgDwWgJCmXdkiicnhdR3MbmdLZYB8gdcr5jGJ5mfck2d+la6UlEwFeHJUs5s6cZlyFUWVDG2Uc27d86JFHgAI5ke0+nEHPBY7rv+Wf1hipzAaC/yeZlmnVEOr7FxN/NcvgSEeTKne56Oq/+LBi8rOjRrLm86NllJYxYbsbjekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412560; c=relaxed/simple;
	bh=bj5fkIbX61L0MhBrMaCBHJdM/TGl/Cqn2WE0N2ZyA1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcfdOISq9nx7xAmem2SBvb2WCXM2O9oR4gPiUf+BpUMJYfjr1dfmEFC0WJiCEiy2yhsDrBPkZuITj+gkR/clZb3PcUlaTHTLP0YQ/FOn/LO0MdihTcNxnPL+V18Puyuo6RUjGmjwjs1WlVnr5ZI+mS63HGr8bgUjTlMbeJPOn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arh5UfIj; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-637dc2292cfso4979288d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760412558; x=1761017358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bj5fkIbX61L0MhBrMaCBHJdM/TGl/Cqn2WE0N2ZyA1E=;
        b=arh5UfIjlQuCuyv385IihPkp6up4x/lITOuVR3cUmr3cjk/5qqEfant6P7CEWrgmHQ
         NpCx2anTStIVvD20GrVdVs8pEuNlMf5h+w5GHWyTeY0WCITGe5kvUjsXMICG4bnOaGtu
         RaEOjLft6dJBRy7ZlaZd9eV420odF1agTfoKnjfVQ5Q5BXSorWIRVp8Uorp8K9LcjERV
         G4KHaESZncINWOq8QXr1jN8ztONKQsYmMEsZtYrCZZ6KkTRe/Qt4VpDSCHoWQPMjD2cs
         ZNa3DOsaaDauWgJ2WDdfdoyai+HWQMY2EaVILcs1M08jP2/LS0cxhoummZnZtMROAaKQ
         VXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760412558; x=1761017358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj5fkIbX61L0MhBrMaCBHJdM/TGl/Cqn2WE0N2ZyA1E=;
        b=Co8/n0Qq9whUFYnXPy6PwI1XIG/xPfY3nPmfUGWXjnBKq9gB1AFlIhxEPB9PYTjsBw
         jTGaAV6Egqbnar/y48UMkuZ+5MOm2pSp92KOOIl0+zMTBrEv9EpiTjvAU2X/tRx+/N7w
         EtQHlk26SPhEblTzHhuAm2iPPglFGejY5ej5vvXIGDuWFrox0zJUGhwnyI1bixfTFaN5
         HExpArdD9U8feU8ufWeYxwBeHPX/dPUmYPWfE4DU/XUCc+vcF+Rw4ZfV/okmLkSHshov
         KcKEDcPtSf/9Rwmqpn6FwyWwXQjUCQ599b+4As9bJ7+hGNKMgd+CXl22rDB2z4krTAyx
         iG9w==
X-Forwarded-Encrypted: i=1; AJvYcCXZUqWbCAHbqV8ka69UeMDYNS7RaEjRhnonWjrjm+Vb+0YHIzwpG8rZN7bqWceACouL0h3WHD43WDOEWJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8XHNwLtFu2545heocXk/bPz8sdcNpUPf2hgmK17BxQ8X/Yat
	Ja5sw6YqGeK1MHauBXIabBILv2x00mBE5eXtQvwjBVAeszVGD5yu+qbvMYbk4kF+UIW92Uf+Xjt
	S4faX3OVO6gyLGWqQcombUeHIvCe9938=
X-Gm-Gg: ASbGncs3RYxSQAcvTB3HTpOBfLg3vy8OUouOStUoJA6IWA79P8Ae8JPxZYSw7EliG1g
	chjcGeV4FzrlvVYCRGxzLx9xQTvCb/xHraNjNgTtOIDQXLlUZekPC2G4JZpqRuwyIA49XUNPqzL
	pq1iN3F33x9K60rB9V+NLASSLPVi5PJ++vxeDt1mgiWNPjSdAyTFk19b+gscUyhHrH8JHMpGhbl
	wPauM0oGd1UIfsxum2PTjMlMQ3oFemu1ecVVD+7Uoijqx/vE93wcC73b4a6jlxSqpkDyc82qoAQ
	ncj/RF+aVroL9SI6NRDEZDC07r/nZb3a8mr9
X-Google-Smtp-Source: AGHT+IF8uLQZO8URAZnyCim5MbAmQ60+6f0ctJuIDBROxEu5YZvbDKsWsAfR4H9oKHvg5eae6TzbtI8YexlXqEqBCFU=
X-Received: by 2002:a05:690c:6002:b0:781:64f:2b15 with SMTP id
 00721157ae682-781064f38e1mr249085787b3.55.1760412557660; Mon, 13 Oct 2025
 20:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014032621.344209-1-kartikey406@gmail.com>
In-Reply-To: <20251014032621.344209-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Oct 2025 08:59:06 +0530
X-Gm-Features: AS18NWDR0ihCYLrwNnu4QRJZn9LRknZfn8rQjMzBqOrGeYibAZFxEPqBOdWYDdk
Message-ID: <CADhLXY4uLWxEiQMpB-KXfHWYKWVGE=UT6OfTUgTnNu6+2VDW5g@mail.gmail.com>
Subject: Re: [PATCH v5] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
To: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Please disregard this patch i will sending fresh patch after testing

