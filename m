Return-Path: <linux-kernel+bounces-735503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E84B09037
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A080A7B9C34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7F2F8C28;
	Thu, 17 Jul 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCvfpQmP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318C2F85FE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764975; cv=none; b=gYBy95hFludIiJwCcW91mKLxqe6sdZ3oadf8/5/IbZREvB/QBSDlDUOkl4Qak/+HNsWFaI82TTlLjgVpsNzTEc9Sq5L0/r7C9HU1jO1VCg9OPpUmujNi1MzRe+T7suRK9L+r/UQDeVShKlkbL6GvvtJnlRN2vaFJDLUPs1z1KT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764975; c=relaxed/simple;
	bh=IA6hJ8fgk1AyBaXpasI0OEb+zaqxzjcAhTHfmZbn060=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkJrpyqPRwwi8TJbCUxPrXG/Hr1LV8uImp0le1fWsBOTm3Q3dU+MR35WjN/Ea6Nz4mo21PjHd/8IysJtUmhDOYjWQ5m9YX5vKi+2k96bUDoPqWoWRoF6l5F3J+9IdcifoZvo36j36MTROccFBu4FoEkT5dKaYQqFvWIqOLq36DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCvfpQmP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752764972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Fn7xRL6bLlxNhOzMEOLtOPne0YN9nCk/GsGQrXpg2I=;
	b=YCvfpQmPHsHL3oeXR20wBz9G42fHWLLdIYwVUa2B5OIdFHv90leME+7YxUnOoGWLoKqtom
	h7IrZ33dsoBmYlGunTCBGH+kbzWR58Rt2E9+Ky+tFI1stWY7q5sTTAXpVhM+UgpyNx6fn5
	FONEj2BNBAR/RAH20FAa2QdbdAiZjqc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-OwAJLguXPUqADwDh-cbkOg-1; Thu, 17 Jul 2025 11:09:30 -0400
X-MC-Unique: OwAJLguXPUqADwDh-cbkOg-1
X-Mimecast-MFC-AGG-ID: OwAJLguXPUqADwDh-cbkOg_1752764970
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so5675805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764969; x=1753369769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Fn7xRL6bLlxNhOzMEOLtOPne0YN9nCk/GsGQrXpg2I=;
        b=IKMKKKSS2t5eRnHgb9A0Oy8b+CzRw4cTD2ZE9j3ZpjsbwwHor9P8GhQfhChRGpumoT
         wopIL08JgmTvMOLvLXMfdXbUSUY4uQk0GhotM/G6GQsAeaKmtQfFnSrTazJ8Rikk5Fox
         ZUZJfCKBPIjB+R+JDmXu/TSqcaE81zTJCUdKWQ4JbHaeawx1epVZv6lTUnaN/1QF3w2i
         qpAlDpsWTaJP3h066FJs4nq6KAe9I/cGbOQHenjcTbGxzXV9Ch4YNomYSvlW7E3jUBiZ
         ho6dJSN5NA8jvh5yrREeIythuFaywwCP7f2Vhk9y5l8nE6dSp0Jfs3lhvlBDg5U3GAOK
         f+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRMoCB84blUj7uZ7OaOJP85uUHAcbQsK4+OdaTKJz2o07Rzx7Fi5ee2gDnBv1/kFG2VaTt4cGPxeP+2d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7l+koKDyl/bb5o5IX0MU251iHGtOqIQPB3/ibkSd3XXDdNMM
	yGixl6KPn8tCdll7IDsXK5l4iVlyqWKcZ8OnqdQh0wnetvzMvXChVd4AtnsHxcgCNFeSS72w2i2
	9uBXqkvXUTXpJi7tdxI6WZudikBUj53aWlUddR3UXn79LsyEE+QKXGqrP/Sj2uL1axVS26yORq1
	oRp09RMoPMEeuTVvnSQrbT9bMRm9V7xHkvfkgNsxuPKViEBxIq
X-Gm-Gg: ASbGncvD1IbO5zd6gODg8sotCjaWuC84rrmfLS1cNrasyOViv1hHXCLxIIKnhTEvlJy
	OQdGF7E8yCCDgDMdKX4RSn1N/EQXuyCqQ4TQds4fs4OF6F+mU4Zy1XF5l4Lq9JWsYAlyDuwT6Mt
	1I7oOQjzJle9gtAhIXRawZ
X-Received: by 2002:a05:600c:c0d6:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-4563555411amr25411085e9.30.1752764969219;
        Thu, 17 Jul 2025 08:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/eDCYFZ31kfW66xBYa23IRr7lnoMRdbHvAeO+KWjHezuj1xUaatTtuMMBTxbexFZiFdmY/UfsgRxVZ3wmS+I=
X-Received: by 2002:a05:600c:c0d6:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-4563555411amr25410695e9.30.1752764968623; Thu, 17 Jul 2025
 08:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717145216.85338-1-seanjc@google.com>
In-Reply-To: <20250717145216.85338-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Jul 2025 17:09:16 +0200
X-Gm-Features: Ac12FXxfMGmUyfYf47rUsqzffL2EJJRz6ZT1rNUJcFMZJsGXn4IB4FR2Bs823Rc
Message-ID: <CABgObfZ2eDbHC53nQ=OpCtr1=U1wtJn1qsBUTBBoBq0442xc7w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: TDX fixes for 6.16-rc7
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:52=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull three TDX fixes for 6.16, two of which have potential to caus=
e ABI
> problems.
>
> The following changes since commit 4578a747f3c7950be3feb93c2db32eb597a3e5=
5b:
>
>   KVM: x86: avoid underflow when scaling TSC frequency (2025-07-09 13:52:=
50 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.16-rc7
>
> for you to fetch changes up to b8be70ec2b47ca62ccb54dc3c2ab9a9c93653e00:
>
>   KVM: VMX: Ensure unused kvm_tdx_capabilities fields are zeroed out (202=
5-07-15 14:04:39 -0700)

Pulled, thanks!

Paolo


