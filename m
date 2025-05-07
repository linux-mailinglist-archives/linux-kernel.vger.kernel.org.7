Return-Path: <linux-kernel+bounces-636860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D8AAD0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6083E982AA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91C4219A94;
	Tue,  6 May 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+wSfYql"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB3218AA3
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570525; cv=none; b=uKbf1z506KXqUA4lvxEJhPGYCNqLS3aKqHHnAA23K2jJQbQShsYJVYeJOkcB8WPdYbUfSj5miRcjB8+hkkA4ndbMtvmWFsfyk/cf6LvYoDAjTcln+vIXmrGyIL4uaz3plfFPuWyf6bT0CdQ9MSktKyrjUwTJ7krDRij8FZUU8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570525; c=relaxed/simple;
	bh=+S4h3p0vxq3kXZdNQAEe3v1v7qZ/wDNhC7lFjI8i/PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rej/4ae/K7KDQgy92kgKSDkcFbZxbxg4AkDXYWSNBBDXSc+rUd/vvCQDeSWZqqI2ZaP2tMTMhC3sUhqC6dWlvfu+QxfjaZvH0k8fL1SF3xvhBBln/LPV2BXPSoNrf5pRhA9TruOWWEjVMiv++7Sf7K93tm8ccJ7Qbw1fEOEmpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+wSfYql; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c27166ab3so4016756a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746570522; x=1747175322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v/2kOEQ7f4YhudvrFYLalEbt9xxrplsO07X7cZc+nM=;
        b=e+wSfYqlRd9/ANec1enAKOVc7ggW+HWUp9ip/SGVsVp2QDw22FtLxV/manilLnOL//
         ytZBBOz09SaoOlFgHKT5xPQSNT81jCf5jxouZxBFlNJeCGYeZOV5G5J1JcFNuM9opK2o
         5eHWQjjYurQh7rLQzr0ES9pup+PReOgibK2dQC0qWdLB2ASjP3PWkjJGVzMquBuh4TLC
         l60Eqj/sazWe06SlJI9Ej7MKqsMZuqR2uC+IQLCZ6kSRoT1ZQ2HH3I06UYr/6KFSEZGI
         tbKsn7lsRLIE4LLhaZfdpggd6KT0nSCwaoWuxSztfhtZ7f6s6ZpDDFcmpZpiv7wece7t
         cZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570522; x=1747175322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v/2kOEQ7f4YhudvrFYLalEbt9xxrplsO07X7cZc+nM=;
        b=D33wy2ZiBR3nrmZ9Mix7YpCuqnlBPZ4GJq4gSMi/uHYCzfiTONOFQzNoEgY0GkVv7V
         6q9evhR76CDdwdmyWDhUF1qrnIHWysWhlSeXqdhCzpCpZ+idXnlJbS+K239wX6NhwDIZ
         ITiwqN5sA5O3fcVVDhuhwUZ8CNtWdndWnvY5DDjHGxe49Ex3ra96Hhg4u8NK5iCyIa7v
         LZvfFZnOpJolmD2lFCyuVmUOaMdJuyQquzTvRoNegK+FQzG8ogcDsR/o8LCZBswatcFQ
         Vswa8hOqR7PRa1buYfNVDI9z7fmc+u+6kn26B3Ly0EV8Kk8FcxQ2lsKoljCO8OBva6d5
         ehdg==
X-Forwarded-Encrypted: i=1; AJvYcCWfEFHVFeLzoKPb2ZloKTUD0sOPypuDgpxEUStyRClREmRzwZgs1O59OmYSx0qL5RwexqS3n3er/IwmTKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMcpBPosHmcDrH/7zm1RUG4lAuhCNxZcJo77PoFu0gwAno8oAP
	4VT/Vsp0G6dfA+D+QuL+yF4I142n28rDoOy30hxWd122izfqrU2O6KW9XYwzZwxqhhPl+GD8UbU
	U6iFFcu5TgbUNNuy6K2Z0qD/c2j7eOSOwhZtF2MsBPHcFefT1cStb
X-Gm-Gg: ASbGncuYwN2LEgUJWJuOQqLNfOme0Eud2cE9Ltd3I6grkPwQU9jS2kxeORD8z9J+MBA
	v/NdE9dldbzZCaTK/oT3sNU9rHFN1JeJtvrPiCqGYvfxKXVaxiqJL8tamjs0gnCvaKJN5h5jAVk
	CtfFvOsZSCfMM1T1bribC7qtCHjGW4Z3OVd1bhZ7PurW2mMgeLjW8C
X-Google-Smtp-Source: AGHT+IHpldh+KeYehqyzhSusObMECh+v3nbLDJEc2Xn9YJ3rYc3uQ6vCugP/rjZ39RtBnJGmQmLDJNnwBD24ugXdfqk=
X-Received: by 2002:a05:6870:46aa:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2db5c08281bmr746672fac.30.1746570522088; Tue, 06 May 2025
 15:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429234908.3751116-2-rdbabiera@google.com> <aBnyDL-GK9WFFXzs@kuha.fi.intel.com>
In-Reply-To: <aBnyDL-GK9WFFXzs@kuha.fi.intel.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Tue, 6 May 2025 15:28:05 -0700
X-Gm-Features: ATxdqUHOuzfhF5WX5G0tlZOQePYH9CXM-g8n5t5PaUSGSV6PIhRtDObFVz6tLZc
Message-ID: <CAPTae5JNVj5ayJNbsH9YQLoJ+3pWPde7ZdeJMVa7HKpHFg+syQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: move tcpm_queue_vdm_unlocked to
 asynchronous work
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: RD Babiera <rdbabiera@google.com>, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:27=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Apr 29, 2025 at 11:49:08PM +0000, RD Babiera wrote:
> > A state check was previously added to tcpm_queue_vdm_unlocked to
> > prevent a deadlock where the DisplayPort Alt Mode driver would be
> > executing work and attempting to grab the tcpm_lock while the TCPM
> > was holding the lock and attempting to unregister the altmode, blocking
> > on the altmode driver's cancel_work_sync call.
> >
> > Because the state check isn't protected, there is a small window
> > where the Alt Mode driver could determine that the TCPM is
> > in a ready state and attempt to grab the lock while the
> > TCPM grabs the lock and changes the TCPM state to one that
> > causes the deadlock.
> >
> > Change tcpm_queue_vdm_unlocked to queue for tcpm_queue_vdm_work,
> > which can perform the state check while holding the TCPM lock
> > while the Alt Mode lock is no longer held. This requires a new
> > struct to hold the vdm data, altmode_vdm_event.

Hi RD,

The patch looks good to me.
Lets also add the callstack of the different threads for reference.

Thanks,
Badhri

> >
> > Fixes: cdc9946ea637 ("usb: typec: tcpm: enforce ready state when queuei=
ng alt mode vdm")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: RD Babiera <rdbabiera@google.com>
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 91 +++++++++++++++++++++++++++--------
> >  1 file changed, 71 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 784fa23102f9..9b8d98328ddb 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -597,6 +597,15 @@ struct pd_rx_event {
> >       enum tcpm_transmit_type rx_sop_type;
> >  };
> >
> > +struct altmode_vdm_event {
> > +     struct kthread_work work;
> > +     struct tcpm_port *port;
> > +     u32 header;
> > +     u32 *data;
> > +     int cnt;
> > +     enum tcpm_transmit_type tx_sop_type;
> > +};
> > +
> >  static const char * const pd_rev[] =3D {
> >       [PD_REV10]              =3D "rev1",
> >       [PD_REV20]              =3D "rev2",
> > @@ -1610,18 +1619,68 @@ static void tcpm_queue_vdm(struct tcpm_port *po=
rt, const u32 header,
> >       mod_vdm_delayed_work(port, 0);
> >  }
> >
> > -static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 =
header,
> > -                                 const u32 *data, int cnt, enum tcpm_t=
ransmit_type tx_sop_type)
> > +static void tcpm_queue_vdm_work(struct kthread_work *work)
> >  {
> > -     if (port->state !=3D SRC_READY && port->state !=3D SNK_READY &&
> > -         port->state !=3D SRC_VDM_IDENTITY_REQUEST)
> > -             return;
> > +     struct altmode_vdm_event *event =3D container_of(work,
> > +                                                    struct altmode_vdm=
_event,
> > +                                                    work);
> > +     struct tcpm_port *port =3D event->port;
> >
> >       mutex_lock(&port->lock);
> > -     tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
> > +     if (port->state !=3D SRC_READY && port->state !=3D SNK_READY &&
> > +         port->state !=3D SRC_VDM_IDENTITY_REQUEST) {
> > +             tcpm_log_force(port, "dropping altmode_vdm_event");
> > +             goto port_unlock;
> > +     }
> > +
> > +     tcpm_queue_vdm(port, event->header, event->data, event->cnt, even=
t->tx_sop_type);
> > +
> > +port_unlock:
> > +     kfree(event->data);
> > +     kfree(event);
> >       mutex_unlock(&port->lock);
> >  }
> >
> > +static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 h=
eader,
> > +                                const u32 *data, int cnt, enum tcpm_tr=
ansmit_type tx_sop_type)
> > +{
> > +     struct altmode_vdm_event *event;
> > +     u32 *data_cpy;
> > +     int ret =3D -ENOMEM;
> > +
> > +     event =3D kzalloc(sizeof(*event), GFP_KERNEL);
> > +     if (!event)
> > +             goto err_event;
> > +
> > +     data_cpy =3D kcalloc(cnt, sizeof(u32), GFP_KERNEL);
> > +     if (!data_cpy)
> > +             goto err_data;
> > +
> > +     kthread_init_work(&event->work, tcpm_queue_vdm_work);
> > +     event->port =3D port;
> > +     event->header =3D header;
> > +     memcpy(data_cpy, data, sizeof(u32) * cnt);
> > +     event->data =3D data_cpy;
> > +     event->cnt =3D cnt;
> > +     event->tx_sop_type =3D tx_sop_type;
> > +
> > +     ret =3D kthread_queue_work(port->wq, &event->work);
> > +     if (!ret) {
> > +             ret =3D -EBUSY;
> > +             goto err_queue;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_queue:
> > +     kfree(data_cpy);
> > +err_data:
> > +     kfree(event);
> > +err_event:
> > +     tcpm_log_force(port, "failed to queue altmode vdm, err:%d", ret);
> > +     return ret;
> > +}
> > +
> >  static void svdm_consume_identity(struct tcpm_port *port, const u32 *p=
, int cnt)
> >  {
> >       u32 vdo =3D p[VDO_INDEX_IDH];
> > @@ -2832,8 +2891,7 @@ static int tcpm_altmode_enter(struct typec_altmod=
e *altmode, u32 *vdo)
> >       header =3D VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTE=
R_MODE);
> >       header |=3D VDO_OPOS(altmode->mode);
> >
> > -     tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_S=
OP);
> > -     return 0;
> > +     return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TC=
PC_TX_SOP);
> >  }
> >
> >  static int tcpm_altmode_exit(struct typec_altmode *altmode)
> > @@ -2849,8 +2907,7 @@ static int tcpm_altmode_exit(struct typec_altmode=
 *altmode)
> >       header =3D VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
> >       header |=3D VDO_OPOS(altmode->mode);
> >
> > -     tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
> > -     return 0;
> > +     return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP=
);
> >  }
> >
> >  static int tcpm_altmode_vdm(struct typec_altmode *altmode,
> > @@ -2858,9 +2915,7 @@ static int tcpm_altmode_vdm(struct typec_altmode =
*altmode,
> >  {
> >       struct tcpm_port *port =3D typec_altmode_get_drvdata(altmode);
> >
> > -     tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SO=
P);
> > -
> > -     return 0;
> > +     return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCP=
C_TX_SOP);
> >  }
> >
> >  static const struct typec_altmode_ops tcpm_altmode_ops =3D {
> > @@ -2884,8 +2939,7 @@ static int tcpm_cable_altmode_enter(struct typec_=
altmode *altmode, enum typec_pl
> >       header =3D VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTE=
R_MODE);
> >       header |=3D VDO_OPOS(altmode->mode);
> >
> > -     tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_S=
OP_PRIME);
> > -     return 0;
> > +     return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TC=
PC_TX_SOP_PRIME);
> >  }
> >
> >  static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum=
 typec_plug_index sop)
> > @@ -2901,8 +2955,7 @@ static int tcpm_cable_altmode_exit(struct typec_a=
ltmode *altmode, enum typec_plu
> >       header =3D VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
> >       header |=3D VDO_OPOS(altmode->mode);
> >
> > -     tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME)=
;
> > -     return 0;
> > +     return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP=
_PRIME);
> >  }
> >
> >  static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum =
typec_plug_index sop,
> > @@ -2910,9 +2963,7 @@ static int tcpm_cable_altmode_vdm(struct typec_al=
tmode *altmode, enum typec_plug
> >  {
> >       struct tcpm_port *port =3D typec_altmode_get_drvdata(altmode);
> >
> > -     tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SO=
P_PRIME);
> > -
> > -     return 0;
> > +     return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCP=
C_TX_SOP_PRIME);
> >  }
> >
> >  static const struct typec_cable_ops tcpm_cable_ops =3D {
> >
> > base-commit: 615dca38c2eae55aff80050275931c87a812b48c
> > --
> > 2.49.0.967.g6a0df3ecc3-goog
>
> --
> heikki

