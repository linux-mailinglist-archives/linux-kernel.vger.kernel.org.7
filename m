Return-Path: <linux-kernel+bounces-724158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47390AFEF3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1711898D15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4602222D7;
	Wed,  9 Jul 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlpUDOES"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED3214813
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080114; cv=none; b=qlXWEF2QU5De/t60MVYrql1Id8jJ/N2iScVQF7pDh/38l0GbKMXB7lui6Hjz0ZYO670qaoGAwd9ffR4+iH5WEPpoQzlgDhmD+zdfZ2MOjxhR8b/OAfHAHZ+1U3kNAWmqpCPDANdQg6ztF/+KIELWquXErXiSxQKhtEI1Yz9gv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080114; c=relaxed/simple;
	bh=vLzbLdb1U5XClidkLMNM7JnUKFZel/V2OLapIrBbU5o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G0/XLa0nMD0TUJu6v3QcQpCQIROSkKDGuj98qKLqs93WYt1FWaWTbS+eIajSOcerIy207NTnfhlQLpkVWT9G6kF1pFzVe5mRAAmFKQVSh2iZ0gIIhTpSUQQUdPpzBNxGgyTlCI/mPK6lspsqX96O/EqH9SfrHZCDb40F4DksB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlpUDOES; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553a66c3567so164e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752080110; x=1752684910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V6LeSQHYUwsCDHk/q0CXvTAidWrzxxRxH53jdjxgKos=;
        b=UlpUDOESePShYUuRnvnVhu0Fl+tMQFmT9wHXwrqM1wye2cW3Um9uV7fPDzJlUrFEbU
         Eu/emY6GFHGtgxTnclh++CbRozwBUt0qf4HOuTiEqiB28V4jOhkJe1SbXVeFyzJjYazF
         ZBsA44NSer5XCTYwfJQnyKIzXp4BHT8LKuAMUQsgfrTSigQ6Vcsgb8umQlw5d/rOGrqR
         YE+CCl6BZgJwsD7Gry0ghms46P/WD0LiSe/dUwYshZQ6TxFtXCn5P+q2bE9An7vVKYoP
         i95c+W2lvnBZk2cvqfRFm+ShqCenttn/75SWGNMH5iiaBup1rvk/Xm1DsDVkpUuSHOxF
         MGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080110; x=1752684910;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6LeSQHYUwsCDHk/q0CXvTAidWrzxxRxH53jdjxgKos=;
        b=pRi/EzYTqbULn+XiPqntZSSJnOp3GBPfxCxPgrUsVtIHxVwk4pLlaP3s6oAufKuNZp
         rAsuhMyyHTP3vn9/i0yZr1sTFlJ+rahXbEvPdj6TfSfKQ3nBl5288Ug7tYZLc0N0htZW
         WYE+jIb0PB2SHFJYTbTR8cEx+1b/xFDX9sg+jnx5Poyl9NBU+57uPq9dPjuDtl2KfzVa
         5cXlWWKIoeffQicFbKNswKLlpW2vW/IpncJ0GfX3yz0+NrM/mQSInx9T/POJNl1V5ptq
         nKROqxiCPJM1n7F3sIrqWzL57b6CJidVrBospFH3ENtdIp3nmUU9yc9fb1SlEElrX4A1
         ddDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Z5jCfsBaYib+Dc+JkrB97I7/O/I/tS4NMChBK7/5AhZv/IkINjZISfvKbWQPWsg8CdB7h0+NGCILVBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+4ZnyQtd+Ildcaf88ec+U33D11+j+gE3ixeT832vgP9jRW1Q
	yv9+j/YInuNoJAhqUN/NSwud2Mj0ZxvPu1XnwsP/NlNYIEaiVyAp/5bodzIShGJ4dXzZE+2Vlfj
	NKzSlzHJi7QemciW8DeMgVitA8Ss3jQExWxk/26Oi
X-Gm-Gg: ASbGncs6KNJlS5C1vz+badspPDNYBf381KjdRElAqGLyLim7a5h9ITkQkYbjO5Op+Gg
	qWhCx0SX5eUzdJDV2tjJBnW+WXWwRHawtmIQ0koDhL4rdF8JOLlHTa6UjCAPp96AWHErs1l0YdY
	fEVPoHnENyU6vY0ELN2QNsrL5g/6y8++N5kQ00ug1ZqyhKX3mpp4zO/Q==
X-Google-Smtp-Source: AGHT+IGT9okQqPsrICn/X7FUpzA1ZLzGeBqb+5MaAmCxIsAJb55shFjxBxMb10S9EL6aXbkegpCt3f5GqNGlkep1/Ok=
X-Received: by 2002:a05:6512:15a6:b0:557:eadb:253d with SMTP id
 2adb3069b0e04-558fa988ed4mr305929e87.1.1752080110144; Wed, 09 Jul 2025
 09:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jianxiong Gao <jxgao@google.com>
Date: Wed, 9 Jul 2025 09:54:57 -0700
X-Gm-Features: Ac12FXwaVU09T6hqP7ML5TAzYqCMnAihwqTx1BO0dyOj4qWUTT9Mnw_kDwS_y4k
Message-ID: <CAMGD6P1Q9tK89AjaPXAVvVNKtD77-zkDr0Kmrm29+e=i+R+33w@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/kvm: Force legacy PCI hole as WB under SNP/TDX
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: binbin.wu@intel.com, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dionna Glaze <dionnaglaze@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, pbonzini@redhat.com, 
	Peter Gonda <pgonda@google.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

I tested this patch on top of commit 8e690b817e38, however we are
still experiencing the same failure.

-- 
Jianxiong Gao

