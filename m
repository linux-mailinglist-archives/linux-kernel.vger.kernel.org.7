Return-Path: <linux-kernel+bounces-881333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEAC28080
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DB73B2695
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C56238159;
	Sat,  1 Nov 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ny07hV6h"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E5189B84
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762005845; cv=none; b=KnNvP+S8OsyboEVhzyPx70C8LbUoW80NBzyC+5FG2tCred1ejSywztV2lPx1kFfaSzuhzTQfe+ekBaISNWIOKb3NTuGeov3NcL9xIdnWhF/JKzS8vNJ2bXBNKxspG5J1tL86yG/UBBDxdv5fme2ExBZ/DUkcNKG5xI0y4g2eBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762005845; c=relaxed/simple;
	bh=H75N9zqQE8CNV6rDIBzWoS8rbF5nkn13BCmmJyzhIIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9zNJntLrdI3IVUMunFadgeO2vr7OEGpo7D+2EakPTNyUnnDiCyn7oFZRAHw1JZplNo2v/7bmwRxPMCKIlQviAFFq2ajEiumvDHOrV4WoP3AH+J7BNZOWy6aMRafoaGt2tMOh7wkVqPQlG+WE2Q6Zf564aOHvjH/2ODoNDhvepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ny07hV6h; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1762005832; x=1762610632; i=wahrenst@gmx.net;
	bh=ujNbH6eMg+bZNP2uEtVpGOtXkKxAPymum+xPkbbI+xM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ny07hV6h75ptbUUpdbR0GosyzRNHLaHXgJvV7fHPnLbS62gF7szbkkH/a7oCIrIH
	 djscwMDRG4eA3Em9rrS5vdhh5qtmW+3HpCk9huv0EV2o1pwKilb/s90aoqcZB+jIQ
	 V1FCwiqczrJrhncAFIF2Mj1EB0uclDkC6sOf1ij/1V26Kw6VIums+8IsIFvxlfruf
	 dyzx3pVQ9uc9NlJcsgp30AFXd/VKWOUSczsqw3o9sOGLHIZ/ut7liqV9VKJT9gWi0
	 bz9jz3FdmCjDhbFwaCePIeRKb2XuiNS6E2LcyDMmVqmlUVlHudWMzh10WK0NWr5AB
	 +L3xbHftVhZkNgo7QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1vfQ2V1h7D-00S6G9; Sat, 01
 Nov 2025 15:03:52 +0100
Message-ID: <e722584e-bb60-434a-b98f-584323eeb9da@gmx.net>
Date: Sat, 1 Nov 2025 15:03:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] platform/raspberrypi: vchiq-mmal: Add support for
 event callbacks.
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
 <20251031-b4-vc-sm-cma-v1-2-0dd5c0ec3f5c@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20251031-b4-vc-sm-cma-v1-2-0dd5c0ec3f5c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZjHos8fjwumulL5HvaGO6HNrmXQkkEeNxLOKbg+NYCPR9449Es8
 fjxM9yrrCORca7j2IMLSxnadCJ7sEoG54SKnLNOXslHYhVIh7KDcoGM3Lv2IDkrusIY/12E
 cq7BDcSSYN9lx2mfMYD2a1E2YpU5mcJKFtEmO39XbODYb29y4ixx9GEQ43zcgZXzc+gd1QI
 N4NbKJbt1mtbMzFUdayYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gK3SSdQFX5c=;83PaTME9JaRPsQgpc6CprDCD1yt
 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
 J0iAtMRb7WsZdM1qUeXQ+UbEaHxOzzUYdGgXBC

Am 31.10.25 um 18:27 schrieb Jai Luthra:
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
>
> The codec uses the event mechanism to report things such as
> resolution changes. It is signalled by the cmd field of the buffer
> being non-zero.
>
> Add support for passing this information out to the client.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>   drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h |   1 +
>   drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h    |  35 ++++++++++=
+++++++++++++++
>   drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c  | 170 ++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++----------
>   drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h  |   4 +++
>   4 files changed, 196 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h b/dri=
vers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> index b33129403a30347fe762d0377cacbda77434c211..0443be8198ea57fcd66d598e=
f7a46309d82ec7b7 100644
> --- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> +++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> @@ -50,6 +50,7 @@ struct mmal_buffer {
>  =20
>   	struct mmal_msg_context *msg_context;
>  =20
> +	u32 cmd;		/* MMAL command. 0=3Ddata. */
>   	unsigned long length;
>   	u32 mmal_flags;
>   	s64 dts;
> diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h b/driver=
s/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> index 1889494425eb65e4e2212e0806084a56087dc61d..7cccd5ee9a9e707b26dada6a=
9506d6a4145de32f 100644
> --- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> +++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> @@ -346,6 +346,41 @@ struct mmal_msg_port_parameter_get_reply {
>   /* event messages */
>   #define MMAL_WORKER_EVENT_SPACE 256
>  =20
> +/* Four CC's for events */
> +#define MMAL_FOURCC(a, b, c, d) ((a) | (b << 8) | (c << 16) | (d << 24)=
)
This define already exists in vchiq-mmal/mmal-common.h
> +
> +#define MMAL_EVENT_ERROR		MMAL_FOURCC('E', 'R', 'R', 'O')
> +#define MMAL_EVENT_EOS			MMAL_FOURCC('E', 'E', 'O', 'S')
> +#define MMAL_EVENT_FORMAT_CHANGED	MMAL_FOURCC('E', 'F', 'C', 'H')
> +#define MMAL_EVENT_PARAMETER_CHANGED	MMAL_FOURCC('E', 'P', 'C', 'H')
> +
> +/* Structs for each of the event message payloads */
> +struct mmal_msg_event_eos {
> +	u32 port_type;	/**< Type of port that received the end of stream */
> +	u32 port_index;	/**< Index of port that received the end of stream */
> +};
> +
> +/** Format changed event data. */
> +struct mmal_msg_event_format_changed {
> +	/* Minimum size of buffers the port requires */
> +	u32 buffer_size_min;
> +	/* Minimum number of buffers the port requires */
> +	u32 buffer_num_min;
> +	/* Size of buffers the port recommends for optimal performance.
> +	 * A value of zero means no special recommendation.
> +	 */
> +	u32 buffer_size_recommended;
> +	/* Number of buffers the port recommends for optimal
> +	 * performance. A value of zero means no special recommendation.
> +	 */
> +	u32 buffer_num_recommended;
> +
> +	u32 es_ptr;
I think it is necessary to explain what ES mean in this context. ptr=20
stands for pointer?
> +	struct mmal_es_format format;
> +	union mmal_es_specific_format es;
> +	u8 extradata[MMAL_FORMAT_EXTRADATA_MAX_SIZE];
> +};
> +
>   struct mmal_msg_event_to_host {
>   	u32 client_component;	/* component context */
>  =20
> diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/driv=
ers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> index 82c2c261fd9cf0669cbd2ca7c814e0703317885a..a115a391908da06e101e1599=
05a4403b91e051c6 100644
> --- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> @@ -145,6 +145,8 @@ struct mmal_msg_context {
>   			/* Presentation and Decode timestamps */
>   			s64 pts;
>   			s64 dts;
> +			/* MMAL buffer command flag */
> +			u32 cmd;
>  =20
>   			int status;	/* context status */
>  =20
> @@ -232,18 +234,6 @@ release_msg_context(struct mmal_msg_context *msg_co=
ntext)
>   	kfree(msg_context);
>   }
>  =20
> -/* deals with receipt of event to host message */
> -static void event_to_host_cb(struct vchiq_mmal_instance *instance,
> -			     struct mmal_msg *msg, u32 msg_len)
> -{
> -	pr_debug("unhandled event\n");
> -	pr_debug("component:%u port type:%d num:%d cmd:0x%x length:%d\n",
> -		 msg->u.event_to_host.client_component,
> -		 msg->u.event_to_host.port_type,
> -		 msg->u.event_to_host.port_num,
> -		 msg->u.event_to_host.cmd, msg->u.event_to_host.length);
> -}
> -
>   /* workqueue scheduled callback
>    *
>    * we do this because it is important we do not call any other vchiq
> @@ -265,13 +255,18 @@ static void buffer_work_cb(struct work_struct *wor=
k)
>   	buffer->mmal_flags =3D msg_context->u.bulk.mmal_flags;
>   	buffer->dts =3D msg_context->u.bulk.dts;
>   	buffer->pts =3D msg_context->u.bulk.pts;
> +	buffer->cmd =3D msg_context->u.bulk.cmd;
>  =20
> -	atomic_dec(&msg_context->u.bulk.port->buffers_with_vpu);
> +	if (!buffer->cmd)
> +		atomic_dec(&msg_context->u.bulk.port->buffers_with_vpu);
>  =20
>   	msg_context->u.bulk.port->buffer_cb(msg_context->u.bulk.instance,
>   					    msg_context->u.bulk.port,
>   					    msg_context->u.bulk.status,
>   					    msg_context->u.bulk.buffer);
> +
> +	if (buffer->cmd)
> +		mutex_unlock(&msg_context->u.bulk.port->event_context_mutex);
>   }
>  =20
>   /* workqueue scheduled callback to handle receiving buffers
> @@ -349,6 +344,7 @@ static int bulk_receive(struct vchiq_mmal_instance *=
instance,
>   	msg_context->u.bulk.buffer_used =3D rd_len;
>   	msg_context->u.bulk.dts =3D msg->u.buffer_from_host.buffer_header.dts=
;
>   	msg_context->u.bulk.pts =3D msg->u.buffer_from_host.buffer_header.pts=
;
> +	msg_context->u.bulk.cmd =3D msg->u.buffer_from_host.buffer_header.cmd;
>  =20
>   	queue_work(msg_context->instance->bulk_wq,
>   		   &msg_context->u.bulk.buffer_to_host_work);
> @@ -451,6 +447,103 @@ buffer_from_host(struct vchiq_mmal_instance *insta=
nce,
>   	return ret;
>   }
>  =20
> +/* deals with receipt of event to host message */
> +static void event_to_host_cb(struct vchiq_mmal_instance *instance,
> +			     struct mmal_msg *msg, u32 msg_len)
> +{
> +	/* FIXME: Not going to work on 64 bit */
> +	struct vchiq_mmal_component *component =3D
> +		(struct vchiq_mmal_component *)msg->u.event_to_host.client_component;
Please don't introduces FIXMEs and address them within the series.=20
Squash them.
> +	struct vchiq_mmal_port *port =3D NULL;
> +	struct mmal_msg_context *msg_context;
> +	u32 port_num =3D msg->u.event_to_host.port_num;
> +
> +	if (msg->u.buffer_from_host.drvbuf.magic =3D=3D MMAL_MAGIC) {
> +		pr_err("%s: MMAL_MSG_TYPE_BUFFER_TO_HOST with bad magic\n",
> +		       __func__);
Please use dev_err and their equavilants. Didn't checkpatch complain here?
> +		return;
> +	}
> +
> +	switch (msg->u.event_to_host.port_type) {
> +	case MMAL_PORT_TYPE_CONTROL:
> +		if (port_num) {
> +			pr_err("%s: port_num of %u >=3D number of ports 1",
> +			       __func__, port_num);
> +			return;
> +		}
> +		port =3D &component->control;
> +		break;
> +	case MMAL_PORT_TYPE_INPUT:
> +		if (port_num >=3D component->inputs) {
> +			pr_err("%s: port_num of %u >=3D number of ports %u",
> +			       __func__, port_num,
> +			       port_num >=3D component->inputs);
> +			return;
> +		}
> +		port =3D &component->input[port_num];
> +		break;
> +	case MMAL_PORT_TYPE_OUTPUT:
> +		if (port_num >=3D component->outputs) {
> +			pr_err("%s: port_num of %u >=3D number of ports %u",
> +			       __func__, port_num,
> +			       port_num >=3D component->outputs);
> +			return;
> +		}
> +		port =3D &component->output[port_num];
> +		break;
> +	case MMAL_PORT_TYPE_CLOCK:
> +		if (port_num >=3D component->clocks) {
> +			pr_err("%s: port_num of %u >=3D number of ports %u",
> +			       __func__, port_num,
> +			       port_num >=3D component->clocks);
> +			return;
> +		}
> +		port =3D &component->clock[port_num];
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!mutex_trylock(&port->event_context_mutex)) {
> +		pr_err("dropping event 0x%x\n", msg->u.event_to_host.cmd);
> +		return;
> +	}
> +	msg_context =3D port->event_context;
> +
> +	if (msg->h.status !=3D MMAL_MSG_STATUS_SUCCESS) {
> +		/* message reception had an error */
> +		//pr_warn
Please drop
> +		pr_err("%s: error %d in reply\n", __func__, msg->h.status);
> +
> +		msg_context->u.bulk.status =3D msg->h.status;
> +	} else if (msg->u.event_to_host.length > MMAL_WORKER_EVENT_SPACE) {
> +		/* data is not in message, queue a bulk receive */
> +		pr_err("%s: payload not in message - bulk receive??! NOT SUPPORTED\n"=
,
> +		       __func__);
> +		msg_context->u.bulk.status =3D -1;
> +	} else {
> +		memcpy(msg_context->u.bulk.buffer->buffer,
> +		       msg->u.event_to_host.data,
> +		       msg->u.event_to_host.length);
> +
> +		msg_context->u.bulk.buffer_used =3D
> +		    msg->u.event_to_host.length;
> +
> +		msg_context->u.bulk.mmal_flags =3D 0;
> +		msg_context->u.bulk.dts =3D MMAL_TIME_UNKNOWN;
> +		msg_context->u.bulk.pts =3D MMAL_TIME_UNKNOWN;
> +		msg_context->u.bulk.cmd =3D msg->u.event_to_host.cmd;
> +
> +		pr_debug("event component:%u port type:%d num:%d cmd:0x%x length:%d\n=
",
> +			 msg->u.event_to_host.client_component,
> +			 msg->u.event_to_host.port_type,
> +			 msg->u.event_to_host.port_num,
> +			 msg->u.event_to_host.cmd, msg->u.event_to_host.length);
> +	}
> +
> +	schedule_work(&msg_context->u.bulk.work);
> +}
> +
>   /* deals with receipt of buffer to host message */
>   static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
>   			      struct mmal_msg *msg, u32 msg_len)
> @@ -1333,6 +1426,7 @@ static int port_disable(struct vchiq_mmal_instance=
 *instance,
>   				mmalbuf->mmal_flags =3D 0;
>   				mmalbuf->dts =3D MMAL_TIME_UNKNOWN;
>   				mmalbuf->pts =3D MMAL_TIME_UNKNOWN;
> +				mmalbuf->cmd =3D 0;
>   				port->buffer_cb(instance,
>   						port, 0, mmalbuf);
>   			}
> @@ -1634,6 +1728,43 @@ int mmal_vchi_buffer_cleanup(struct mmal_buffer *=
buf)
>   }
>   EXPORT_SYMBOL_GPL(mmal_vchi_buffer_cleanup);
>  =20
> +static void init_event_context(struct vchiq_mmal_instance *instance,
> +			       struct vchiq_mmal_port *port)
> +{
> +	struct mmal_msg_context *ctx =3D get_msg_context(instance);
> +
> +	mutex_init(&port->event_context_mutex);
> +
> +	port->event_context =3D ctx;
> +	ctx->u.bulk.instance =3D instance;
> +	ctx->u.bulk.port =3D port;
> +	ctx->u.bulk.buffer =3D
> +		kzalloc(sizeof(*ctx->u.bulk.buffer), GFP_KERNEL);
> +	if (!ctx->u.bulk.buffer)
> +		goto release_msg_context;
Since this whole function can fail, it should return an error code.
> +	ctx->u.bulk.buffer->buffer =3D kzalloc(MMAL_WORKER_EVENT_SPACE,
> +					     GFP_KERNEL);
> +	if (!ctx->u.bulk.buffer->buffer)
> +		goto release_buffer;
> +
> +	INIT_WORK(&ctx->u.bulk.work, buffer_work_cb);
> +	return;
> +
> +release_buffer:
> +	kfree(ctx->u.bulk.buffer);
> +release_msg_context:
> +	release_msg_context(ctx);
> +}
> +
> +static void free_event_context(struct vchiq_mmal_port *port)
> +{
> +	struct mmal_msg_context *ctx =3D port->event_context;
> +
> +	kfree(ctx->u.bulk.buffer->buffer);
> +	kfree(ctx->u.bulk.buffer);
> +	release_msg_context(ctx);
> +}
> +
>   /* Initialise a mmal component and its ports
>    *
>    */
> @@ -1683,6 +1814,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_in=
stance *instance,
>   	ret =3D port_info_get(instance, &component->control);
>   	if (ret < 0)
>   		goto release_component;
> +	init_event_context(instance, &component->control);
>  =20
>   	for (idx =3D 0; idx < component->inputs; idx++) {
>   		component->input[idx].type =3D MMAL_PORT_TYPE_INPUT;
> @@ -1693,6 +1825,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_in=
stance *instance,
>   		ret =3D port_info_get(instance, &component->input[idx]);
>   		if (ret < 0)
>   			goto release_component;
> +		init_event_context(instance, &component->input[idx]);
>   	}
>  =20
>   	for (idx =3D 0; idx < component->outputs; idx++) {
> @@ -1704,6 +1837,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_in=
stance *instance,
>   		ret =3D port_info_get(instance, &component->output[idx]);
>   		if (ret < 0)
>   			goto release_component;
> +		init_event_context(instance, &component->output[idx]);
>   	}
>  =20
>   	for (idx =3D 0; idx < component->clocks; idx++) {
> @@ -1715,6 +1849,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_in=
stance *instance,
>   		ret =3D port_info_get(instance, &component->clock[idx]);
>   		if (ret < 0)
>   			goto release_component;
> +		init_event_context(instance, &component->clock[idx]);
>   	}
>  =20
>   	*component_out =3D component;
> @@ -1740,7 +1875,7 @@ EXPORT_SYMBOL_GPL(vchiq_mmal_component_init);
>   int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance=
,
>   				  struct vchiq_mmal_component *component)
>   {
> -	int ret;
> +	int ret, idx;
>  =20
>   	if (mutex_lock_interruptible(&instance->vchiq_mutex))
>   		return -EINTR;
> @@ -1752,6 +1887,13 @@ int vchiq_mmal_component_finalise(struct vchiq_mm=
al_instance *instance,
>  =20
>   	component->in_use =3D false;
>  =20
> +	for (idx =3D 0; idx < component->inputs; idx++)
> +		free_event_context(&component->input[idx]);
> +	for (idx =3D 0; idx < component->outputs; idx++)
> +		free_event_context(&component->output[idx]);
> +	for (idx =3D 0; idx < component->clocks; idx++)
> +		free_event_context(&component->clock[idx]);
> +
>   	mutex_unlock(&instance->vchiq_mutex);
>  =20
>   	return ret;
> diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h b/driv=
ers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> index 8c3959f6f97fb21bcaf2f21589ef291e754e7c19..190a0f42bd6b22c7493463da=
94c094265d85d8fa 100644
> --- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> +++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> @@ -79,6 +79,10 @@ struct vchiq_mmal_port {
>   	vchiq_mmal_buffer_cb buffer_cb;
>   	/* callback context */
>   	void *cb_ctx;
> +
> +	/* ensure serialised use of the one event context structure */
> +	struct mutex event_context_mutex;
> +	struct mmal_msg_context *event_context;
>   };
>  =20
>   struct vchiq_mmal_component {
>


