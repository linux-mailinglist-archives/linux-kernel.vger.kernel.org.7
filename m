Return-Path: <linux-kernel+bounces-847488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF8BCAF76
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372B11A64A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644728152A;
	Thu,  9 Oct 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zk0CMk1v"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7A280325
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046307; cv=none; b=SoxwUWm+Xa7ygHGHVTJdpdg2YWgeX3XNY1dToKarsykH+gg/3ud4Y59xBuYmmz4Rb97pevfEF9nEI7akuvwk2u2Yq+MydbukyevIlA95+gFKEe2GFYL34Fqk1m8MIWAPyisBMmSmGenK9YgJO9HNjvt3aZYR/B5Ke16/eq/Y3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046307; c=relaxed/simple;
	bh=QreGZIUWwFSUpS0keexw5E+JPR6ESha9HKz5hFX0Bds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9bBqZ9rLiW5EXUfUyn7aHVhzzAV6keVAUmgaEeORaF1fIIo0MHBJJDqpmBne+9XFl7DY3qA1gGEnBCiZiJtp4DvEoiwZZUy+3k/Kg4WV/4x0POK8m84vYWetPdqAiaKBb/3LwyA/qaRElD+tKkF6h92ik6YD12KWVhRo37NTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zk0CMk1v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so4903a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760046304; x=1760651104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QreGZIUWwFSUpS0keexw5E+JPR6ESha9HKz5hFX0Bds=;
        b=Zk0CMk1vQHyCII1f1WqnR56nHuFrfgEHSb7iFObRSNwFu2rb6OUyFbPF4lbf6nDGQ8
         13PHIdof3xbPv0pwv+N9G4XUfR3/Ns+n3hr8JqwHc0vS+xciFcx7GiFXBBNmT9sv5EvL
         s+rWnWtnY91jDUfA19r90eBNwWxrEhQh5i+AVh7vZhKm93t5SXXB19A8SZJhvVmL9XlJ
         P2wqe8UqH8YRdOUs+z1bMTZ+ttTgKPGO+YlAdrYvcTUoAqjYJg3lTqCrPCoc6TjNW/97
         aG4MKtHE5mLsNecCsSYZsFdWHOm8PCHFpE4i5QgebvZaM0VIZL6z1SptF//WTFX8ASCj
         I5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046304; x=1760651104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QreGZIUWwFSUpS0keexw5E+JPR6ESha9HKz5hFX0Bds=;
        b=AUheQeRBwkncuNx8aFbEw7UX+/nKSUmb/r7pfJ1gFfGE3wBNdA9vmCEea5dGv4xCbZ
         m5h5dEtTBVZNLrB/xRsQCzRsCmgE44DpeTWkJ/5p4Xv98d8i+aM8J/YBLeh4MYLELaa9
         VWkgYexMRBQa2i3Ul/QMLADuC0a2QrEtp+9G7/UZRmwRFRbMe4UvIvZpXHakPs7BZ8sV
         OZ9W2ahO6MZC9OXLRoxMyces461uPrO2cIUaoDzBcsk2bOB22v2U8PBUNPt6geJ3Pg02
         jAuY1EwuSTuoRHzSnoscmEDnqd59IBLVZJftvu7+Zdpf+MQtMLtOjaNVkmkAdxrsj91k
         IRQw==
X-Forwarded-Encrypted: i=1; AJvYcCUfyJ+kUu9XErQslvB2NAZNYHJbk0ArZCph/D9PNno0SRwX8XbL8aHyt3fwN0F9CkT5L8vtAkr8Wisadxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtnCyVIzE/rSBdcN1kcyx9eSN81AKnBzJ0emcBx0W0ESM4XlBp
	F33kHulwAWgz5pij0aC+2qIzMRgXl7xBWpwKWHtOxDA4JfLzW68+0qMQFs4ezoiT0j8dmhxAMHu
	iiorD+d3pDy/O4LccCaWJ93x9N9YjxabeWzMaX98N
X-Gm-Gg: ASbGncsaDeSnXkDo1bhV2wMAEaVKaaQ/uCXPX2mkk6HwrrtHvEq4kuhNihk+UUCnhgC
	KjVT+UKaQfTh1omFErvRCIg5flr1bBhk2dva6+VlEz7rdZX6JW3Jr6sJgp/g9XIWoVnMlQB3EyJ
	esxbF4OAXCDajJKD10woyOlEUsE++aIsU2jMa1TckL4Z9mYbKVJN+xTheGWAV+s5rcGWu3epy8w
	/HjdkX6pyisiGhMcWy4uOhEr8dOUVRm5YfgJelZtMF7g0Zb
X-Google-Smtp-Source: AGHT+IF7ya22VR4MsSm2/ApcHvwUPsH55KorEJeGrqSsdbLUu0dLnfCzEQZXQiVR4PHOuAbLG3cDz/biyLB252V/zQI=
X-Received: by 2002:a05:6402:70d:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-639d52ea25amr274550a12.6.1760046304074; Thu, 09 Oct 2025
 14:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-2-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 14:44:51 -0700
X-Gm-Features: AS18NWAuXxHhioaQeq_mMaK8Wdn5ce4wM5-COHrH8ohtUZg-eDZxQjR9lDMUiiY
Message-ID: <CALMp9eTpUsozsbp2_6JDPdKJ5YT0SwcJ+2G9KZJEp46Ha8j9xQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] KVM: selftests: Minor improvements to asserts in test_vmx_nested_state()
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:02=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Display the address as hex if the asserts for the vmxon_pa and vmcs12_pa
> fail, and assert that the flags are 0 as expected.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Jim Mattson <jmattson@google.com>

